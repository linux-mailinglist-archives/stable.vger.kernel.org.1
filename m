Return-Path: <stable+bounces-39645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A228A53F2
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146691C21F1F
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0911F84A5C;
	Mon, 15 Apr 2024 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KxpYRVzn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A837F47B;
	Mon, 15 Apr 2024 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191389; cv=none; b=t8Ft7FnQYp6D6VL4PfrjJa5u/zJ+L4LnwLy9O/Qj3euqAq0g1RvmDHzxQWNE6WoHJjjvCg4vF7S2HXUIc9YKy2eKGrXdiBMPM510vxl86fZKzJ3ZVy0bkPygh2HL4iaMqpGtUX7/r4JVLJLymYH/pei/XvEYJkJMRawECx0Cguk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191389; c=relaxed/simple;
	bh=CqclnSIylVtN7eH2/1sSJeo2y/fcI9aeuawohaL4BSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1VEJKWzIZd59JqDnQO78k/Ka9jbjXUpvVcGB4Hn61HV5pJqNHr8/ToJTrlIbEdB6Kyit22rMCKLwyl26E/bnY4sExBuqViiZj3tlZ0mrtCi05hnwuDZjEoC+dE69rngLy+7UODfg5C+hKK6ckKXwSt9SRvKBRUGlylkzIlWEsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KxpYRVzn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406BBC113CC;
	Mon, 15 Apr 2024 14:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713191389;
	bh=CqclnSIylVtN7eH2/1sSJeo2y/fcI9aeuawohaL4BSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KxpYRVznaOnCJAo1lIbZ8JdISkMipHYgZfwO8ECr4GQgF7OP+ZMvA0TTGS+Nao1Ue
	 I5qBzZpQcpFKacme+Qy2YRhSXGIv/Wr1NJINt3gQRxfqsSGaRgKr2KArUrm9cCEzP6
	 JXBDczSBJbZQZ67VDEY1LAb2Kc/qKYYYrCHDuMCk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Deucher <alexander.deucher@amd.com>,
	Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
	Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCH 6.8 125/172] drm/amdkfd: Reset GPU on queue preemption failure
Date: Mon, 15 Apr 2024 16:20:24 +0200
Message-ID: <20240415142004.184854854@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141959.976094777@linuxfoundation.org>
References: <20240415141959.976094777@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

commit 8bdfb4ea95ca738d33ef71376c21eba20130f2eb upstream.

Currently, with F32 HWS GPU reset is only when unmap queue fails.

However, if compute queue doesn't repond to preemption request in time
unmap will return without any error. In this case, only preemption error
is logged and Reset is not triggered. Call GPU reset in this case also.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1997,6 +1997,7 @@ static int unmap_queues_cpsch(struct dev
 		dev_err(dev, "HIQ MQD's queue_doorbell_id0 is not 0, Queue preemption time out\n");
 		while (halt_if_hws_hang)
 			schedule();
+		kfd_hws_hang(dqm);
 		return -ETIME;
 	}
 



