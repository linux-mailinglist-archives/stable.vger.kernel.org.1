Return-Path: <stable+bounces-73845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2002D97068E
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 12:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D269A2813B3
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 10:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB9A14A0A0;
	Sun,  8 Sep 2024 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LO8qZ5Oe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D301B85EF
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725791152; cv=none; b=dl5AP1IrJdzdmWUWcZFHlGjz7sS30Hw0FkbcKSY6dZs9N8f2uQyvKPYQJ7ehZeHk8nSnQhcKOG4IXXj0YmBenQaS54d85/O5vod+7MZcn10UHa6Xnj0vbA6Hh+S/Hlf15vCuAYLK0G/4JCKP4NeSriGxwzJ/O4yhk+8oUjzW790=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725791152; c=relaxed/simple;
	bh=F2o8gXXaBkbBnCpdX/H5eAJyRyL/fQAJHHW1FP8Uje4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=t/JSIwzxiGWFjrgEwqaTt2rjaQGyvQyKgAMT6syp9Rw3wjGPekTzbD4g9u+HrRKrq3xjmQhGe64SlCd0qDbMqfYrJxJRFThYRTZjBl8DoXV/1Jvu3uNzo/N29dkc9BpFZ/fwJrWTLlcb+N08CbQdh3oDdimL241ndRckRnuhjHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LO8qZ5Oe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F03C4CEC3;
	Sun,  8 Sep 2024 10:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725791151;
	bh=F2o8gXXaBkbBnCpdX/H5eAJyRyL/fQAJHHW1FP8Uje4=;
	h=Subject:To:Cc:From:Date:From;
	b=LO8qZ5OekOhxm81aSHid50+UJxNMLlWxLwD2UCJPS+HIp1b/6uHd5Ja7dY0oo75/N
	 9/am9HjSqIlw6XbRvs8NVn56D0MK1a2zK2vdR+II6rHQgWvbX0jy64gwnXVRlB8yAM
	 Y3OzJrfL2DHw/l8bmv7w1JC3dnN6ZAbMp3cVOMkQ=
Subject: FAILED: patch "[PATCH] ksmbd: Unlock on in ksmbd_tcp_set_interfaces()" failed to apply to 5.15-stable tree
To: dan.carpenter@linaro.org,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 12:25:48 +0200
Message-ID: <2024090848-botch-appointee-7cb2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 844436e045ac2ab7895d8b281cb784a24de1d14d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090848-botch-appointee-7cb2@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

844436e045ac ("ksmbd: Unlock on in ksmbd_tcp_set_interfaces()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 844436e045ac2ab7895d8b281cb784a24de1d14d Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Thu, 29 Aug 2024 22:22:35 +0300
Subject: [PATCH] ksmbd: Unlock on in ksmbd_tcp_set_interfaces()

Unlock before returning an error code if this allocation fails.

Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index a84788396daa..aaed9e293b2e 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -624,8 +624,10 @@ int ksmbd_tcp_set_interfaces(char *ifc_list, int ifc_list_sz)
 		for_each_netdev(&init_net, netdev) {
 			if (netif_is_bridge_port(netdev))
 				continue;
-			if (!alloc_iface(kstrdup(netdev->name, GFP_KERNEL)))
+			if (!alloc_iface(kstrdup(netdev->name, GFP_KERNEL))) {
+				rtnl_unlock();
 				return -ENOMEM;
+			}
 		}
 		rtnl_unlock();
 		bind_additional_ifaces = 1;


