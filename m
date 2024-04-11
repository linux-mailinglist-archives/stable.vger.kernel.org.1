Return-Path: <stable+bounces-38894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7858A10E3
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15020B21D78
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427ED148FFF;
	Thu, 11 Apr 2024 10:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j7RzlMzm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011211465BF;
	Thu, 11 Apr 2024 10:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831907; cv=none; b=SlSfqZKsAzjCPE2mTRkuxAutfP9JE7WfgohHf04RucQv+NxBsybbVtj7s45/Q19eXjcBGvxQoWvZ8nO+2bXrGjljsT6JanIDqXV9K8TP+hbND9hhwbSxEgh+E/1XIX07eiMMkmA/YEP5/Da3aGKpFsjE74npFoE12zuY6RVcwoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831907; c=relaxed/simple;
	bh=LRwgfnCugkiZof7lE2CgNVS7MwdUXJu/3xidjX0Jikg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZpW5GwIQa91n8zW56mUCUkQYSxvm6H/kf8QsZQjfDxhLUGDF44t4EoeU5fs9TsAR9813EvbLS+V2d6paCe//6lT900/p+SpVqJ98maKIf9hMVHgPz0PUHyyREyPiHdlVz1G0RJ6qkvNx1WjsH2aDD+9HfPER2+WaBFKdNAwdnG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j7RzlMzm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72791C433F1;
	Thu, 11 Apr 2024 10:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712831906;
	bh=LRwgfnCugkiZof7lE2CgNVS7MwdUXJu/3xidjX0Jikg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j7RzlMzmN1vbha6LlbjtoRKFFQPmfxm/HqKDJxx5J9vgYmLna7KX079W9GSU4Hkuu
	 Vt0Ysgw/xymqIrcTeVoaXIWYeHRc4TymWRbU5+1kKocj3XMLoJrqLHV4CHSy6wMA+b
	 q/MObpz31qreXpy3dmYY5imADy18yE0+agxwFMRw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH 5.10 166/294] staging: vc04_services: fix information leak in create_component()
Date: Thu, 11 Apr 2024 11:55:29 +0200
Message-ID: <20240411095440.637287430@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095435.633465671@linuxfoundation.org>
References: <20240411095435.633465671@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

commit f37e76abd614b68987abc8e5c22d986013349771 upstream.

The m.u.component_create.pid field is for debugging and in the mainline
kernel it's not used anything.  However, it still needs to be set to
something to prevent disclosing uninitialized stack data.  Set it to
zero.

Fixes: 7b3ad5abf027 ("staging: Import the BCM2835 MMAL-based V4L2 camera driver.")
Cc: stable <stable@kernel.org>
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/2d972847-9ebd-481b-b6f9-af390f5aabd3@moroto.mountain
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -942,6 +942,7 @@ static int create_component(struct vchiq
 	m.u.component_create.client_component = component->client_component;
 	strscpy_pad(m.u.component_create.name, name,
 		    sizeof(m.u.component_create.name));
+	m.u.component_create.pid = 0;
 
 	ret = send_synchronous_mmal_msg(instance, &m,
 					sizeof(m.u.component_create),



