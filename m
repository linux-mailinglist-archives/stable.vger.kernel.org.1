Return-Path: <stable+bounces-102151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 657B59EF109
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F13116F73B
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876E822331C;
	Thu, 12 Dec 2024 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O4NsWTfc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BE4223301;
	Thu, 12 Dec 2024 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020170; cv=none; b=JYEE2jFf1jG6fVMVQYNzeCZDwFgZlolGQKlv4yjrTX/j9FkOgeaTASTkeKPTtTMGJ0/FMV3rhZZX9SfwAHglsZ26uRjobgA1m0yupx4DHVdaNqEqg88GvVJI8vXrwGEJsgSts+f7fcPfavTnUDUuYZswI8PNAENglH7Ugt9PwAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020170; c=relaxed/simple;
	bh=5IUqh0i+ua8CeE6IbI+akS4aa6XC/r6DJIqZbZEs0iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJwqN03zNFkzbA8xrduTcVdx/lQ8nr/PCXaZ4ZlEbtpl/jbxShFYJcLUEYyacDmIrK/EZgRJ4qhKYJyX5+g0ei5vOa9NvLGCZfuBUb0J1e06WnpvYyTT2G9O/jab53JdUYyM3+lhwMM5VEk6ulxXmMBTCJyjHMOyKlQCIw7NGG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O4NsWTfc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BCFC4CECE;
	Thu, 12 Dec 2024 16:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734020169;
	bh=5IUqh0i+ua8CeE6IbI+akS4aa6XC/r6DJIqZbZEs0iU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O4NsWTfcfI7CSV/aMj5BlDZ2vzgPtzQhcTE7kZCj7U2gu0iyR3DcZvO5p4DeLPl5j
	 7fPh4YCidYErrzdNa2LMrCS2eVkQ24XTUgGTUd+nhPXsr8kuySF+ANt5hgjsJIDJ2d
	 s66HOK5V/yjAd5O5gydgFjlKOv9Z5o868LbEK6HU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH 6.1 396/772] platform/chrome: cros_ec_typec: fix missing fwnode reference decrement
Date: Thu, 12 Dec 2024 15:55:41 +0100
Message-ID: <20241212144406.280387503@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

commit 9c41f371457bd9a24874e3c7934d9745e87fbc58 upstream.

The device_for_each_child_node() macro requires explicit calls to
fwnode_handle_put() upon early exits (return, break, goto) to decrement
the fwnode's refcount, and avoid levaing a node reference behind.

Add the missing fwnode_handle_put() after the common label for all error
paths.

Cc: stable@vger.kernel.org
Fixes: fdc6b21e2444 ("platform/chrome: Add Type C connector class driver")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://lore.kernel.org/r/20241013-cross_ec_typec_fwnode_handle_put-v2-1-9182b2cd7767@gmail.com
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/chrome/cros_ec_typec.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -446,6 +446,7 @@ static int cros_typec_init_ports(struct
 	return 0;
 
 unregister_ports:
+	fwnode_handle_put(fwnode);
 	cros_unregister_ports(typec);
 	return ret;
 }



