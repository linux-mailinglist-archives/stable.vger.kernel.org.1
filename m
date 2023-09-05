Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12F67932C3
	for <lists+stable@lfdr.de>; Wed,  6 Sep 2023 01:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243806AbjIEX71 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 5 Sep 2023 19:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjIEX7W (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 5 Sep 2023 19:59:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A049CCE0
        for <stable@vger.kernel.org>; Tue,  5 Sep 2023 16:59:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7493fcd829so2625534276.3
        for <stable@vger.kernel.org>; Tue, 05 Sep 2023 16:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693958357; x=1694563157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SzJfFJBh10albvAF7xPhTVf2fYkrZEg2s13Q8JWYNz8=;
        b=GZ4A9EzfHc9bXdApH3uxKjEiDhHjdwKkHS401uf1guoKZ3xJRXXfyFTmIUiGEijxDF
         nPA52X5QDv5FAZM8H9MnNMcdzf4+FKfilt+5PJAkssvr8hX8BpxbskWLpYCrn1dFT1Tz
         X8nUq66tctLBkKEueXtgP+HffHCEpl+VGUP54FOD7d/op3vIOzdhIGjJ3K/X/C73wt+c
         pak4PsDlPoQq5wiE73BQKXJka6sFG3i/3txx5P5g6m09zM9L9nymHTyGQmEwUhRtVlFj
         DCBGchnU7Ci+5kljUvOklzJxDMCYT2QNpr9IHyWuCgV6K6dBwIMYgvE4uEcpNZm0hW/+
         am7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693958357; x=1694563157;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SzJfFJBh10albvAF7xPhTVf2fYkrZEg2s13Q8JWYNz8=;
        b=hgvlyk9famVErZWNYhQ9nJaq7Mcn9Ix3f0QwYRv5kbchdcIYkSjZ7wLaS+t5RHrjNw
         UweHJe/8z1RQEXiio8t+SLWoK8QTdCcBlZaJV1RDhISt5im2fOrwr80L2B6IIQilprcX
         6i4u6hg5GGuMaUsYXzS1DB3/g/D3mV6lTCPMCUn3zSFgaWEbA9Ism1QrWWuddOrZY1aU
         Xex8oXHmQz+VUR1c7DRoVe8/banCUbg9BwOGHh/41S+yOa21ALJCR0ytc9dX07sVRyRu
         9IvIaEnISQ4jSD3Xs7FnLquJkQHeHuB4cJr8DhZzss3i1Wph+3wgDA4TDsD7QApLQV7s
         F+3g==
X-Gm-Message-State: AOJu0YzNiDPagxSOEogb1X1mRJNjvagJ/1IaOWw903Rkeo3+rYfUp+Sk
        RifkbZdk0DnSoYIlJ+T6RCimycxVyn2zypo5i78MHe5OnAb6qpRAwuQ8Fc0dXDHnC3A818TEHid
        Lff6Qm/eWTHodf5kI0nJr6ycxLuK7FMagtu+UhSdHtwILsSqBXbP0//M373Y=
X-Google-Smtp-Source: AGHT+IFmTO68fo4qa2oEHn9gaVkksWliqtaXAItVBHwS/hsMjrc8PKxyC2MiduaC44YucvzOxteglOgM9A==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a25:69cd:0:b0:d0b:d8cd:e661 with SMTP id
 e196-20020a2569cd000000b00d0bd8cde661mr331445ybc.12.1693958357578; Tue, 05
 Sep 2023 16:59:17 -0700 (PDT)
Date:   Tue,  5 Sep 2023 18:58:46 -0500
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230905235846.142217-1-jrife@google.com>
Subject: [PATCH] net: Avoid address overwrite in kernel_connect
From:   Jordan Rife <jrife@google.com>
To:     stable@vger.kernel.org
Cc:     dborkman@kernel.org, Jordan Rife <jrife@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 0bdf399 upstream.

This fix applies to all stable kernel versions 4.19+.

BPF programs that run on connect can rewrite the connect address. For
the connect system call this isn't a problem, because a copy of the address
is made when it is moved into kernel space. However, kernel_connect
simply passes through the address it is given, so the caller may observe
its address value unexpectedly change.

A practical example where this is problematic is where NFS is combined
with a system such as Cilium which implements BPF-based load balancing.
A common pattern in software-defined storage systems is to have an NFS
mount that connects to a persistent virtual IP which in turn maps to an
ephemeral server IP. This is usually done to achieve high availability:
if your server goes down you can quickly spin up a replacement and remap
the virtual IP to that endpoint. With BPF-based load balancing, mounts
will forget the virtual IP address when the address rewrite occurs
because a pointer to the only copy of that address is passed down the
stack. Server failover then breaks, because clients have forgotten the
virtual IP address. Reconnects fail and mounts remain broken. This patch
was tested by setting up a scenario like this and ensuring that NFS
reconnects worked after applying the patch.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 net/socket.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/socket.c b/net/socket.c
index ce70c01eb2f3e..db9d908198f21 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -3468,7 +3468,11 @@ EXPORT_SYMBOL(kernel_accept);
 int kernel_connect(struct socket *sock, struct sockaddr *addr, int addrlen,
 		   int flags)
 {
-	return sock->ops->connect(sock, addr, addrlen, flags);
+	struct sockaddr_storage address;
+
+	memcpy(&address, addr, addrlen);
+
+	return sock->ops->connect(sock, (struct sockaddr *)&address, addrlen, flags);
 }
 EXPORT_SYMBOL(kernel_connect);
 
-- 
2.42.0.283.g2d96d420d3-goog

