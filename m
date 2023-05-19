Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A1A70A227
	for <lists+stable@lfdr.de>; Fri, 19 May 2023 23:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjESVwo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 19 May 2023 17:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjESVwa (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 19 May 2023 17:52:30 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC4E10F8
        for <stable@vger.kernel.org>; Fri, 19 May 2023 14:52:11 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-561afe72a73so52008017b3.0
        for <stable@vger.kernel.org>; Fri, 19 May 2023 14:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684533130; x=1687125130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ezXSeNe7/yIUHA40nQ1HzfdzkERT0quxzTGuCdKKnYc=;
        b=I61PPPq4ulT4nc6hqI7x5CMT0VuokZIcep7PHOMPcQ/p96Y/m27mzAbcpNodlOSpzw
         ezyd5jIzljQqMHJI2rXN3focGzbFt30gPTtrOglo3bFmaPY8DpAuAGXR6p2sYGSFkOfx
         OX4Pd8tkaAIrIUJ6xe5lwICzYuQUEI70OUshd82BgEI3hN79GFnF3+UBu/idgi/e7EEX
         kAg+tg2APxx/r7lDuR4er0c5yNejZZXeT+WfePwnf9pY9EP4MLYKyHj7Y2nSjRnOBfzu
         0Qq79Vk3cqdVCtm67Rjak3J7/WcWhVpOWZ0QXsmMz+D74teIM8C/VaPMgZnYFxq8u+IR
         UR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684533130; x=1687125130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ezXSeNe7/yIUHA40nQ1HzfdzkERT0quxzTGuCdKKnYc=;
        b=MfeEHZFewjoV9MY0Pv/CvBjrQ3VlJipSCBz5OB6VbLNm0BxD0JF9EbODWNVYRgZllY
         1CLwfUcokWR4IjVCR2PS28YGP1B/SzHAQH1pVC+GHc7Lw70qmIJgsVwmJdvgSHfZHETT
         Kok7Fuq1CmYfN7AbGtRSCiiV85AZU6E4egqhw9mzEwRUSkleyG3+afR+YXq9WDbLj+4a
         ewHIsoTYydmc3g+79yXT893E7ijFOvQKFCg12Fr75u0ctOrZEF68sBSGg8eyX1y00wyq
         THqGkprl+UiWBTIlMOHpDDgJVkGzijg6zzoDtGyWDULa9nvESerFNX6PcXuuzXKUs255
         ST+w==
X-Gm-Message-State: AC+VfDxCZmDr5MFg6gAQkfwNvJ9wpGalz4JUgb0s65Yrk3k5rRzV0vcs
        9O2R3zKzmbKQnw68TmFEwZMrMQr1axMNT5clDuIwt7Dw6GCGSo0=
X-Google-Smtp-Source: ACHHUZ7ni7yIXIClyu8KfLfSeYBwQD3QR1eReHQhnABUYS5cFfAkBOyTz77fNzOHEUdH2HkvTRuarKn1+mqHV7TGUbo=
X-Received: by 2002:a81:4854:0:b0:561:9092:d60a with SMTP id
 v81-20020a814854000000b005619092d60amr3629979ywa.42.1684533130035; Fri, 19
 May 2023 14:52:10 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 19 May 2023 17:51:59 -0400
Message-ID: <CAHC9VhRPvkdk6t1zkx+Y-QVP_vJRSxp+wuOO0YjyppNDLTNg7g@mail.gmail.com>
Subject: Stable backport of de3004c874e7 ("ocfs2: Switch to security_inode_init_security()")
To:     stable@vger.kernel.org
Cc:     Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello,

I would like to request the backport of the commit below to address a
kernel panic in ocfs2 that was identified by Valentin Vidi=C4=87 in this
thread:

https://lore.kernel.org/linux-security-module/20230401214151.1243189-1-vvid=
ic@valentin-vidic.from.hr

While Valentin provides his own patch in the original message, the
preferred patch is one that went up to Linus during the last merge
window; Valentin has tested the patch and confirmed that it resolved
the reported problem.

  commit de3004c874e740304cc4f4a83d6200acb511bbda
  Author: Roberto Sassu <roberto.sassu@huawei.com>
  Date:   Tue Mar 14 09:17:16 2023 +0100

   ocfs2: Switch to security_inode_init_security()

   In preparation for removing security_old_inode_init_security(), switch t=
o
   security_inode_init_security().

   Extend the existing ocfs2_initxattrs() to take the
   ocfs2_security_xattr_info structure from fs_info, and populate the
   name/value/len triple with the first xattr provided by LSMs.

   As fs_info was not used before, ocfs2_initxattrs() can now handle the ca=
se
   of replicating the behavior of security_old_inode_init_security(), i.e.
   just obtaining the xattr, in addition to setting all xattrs provided by
   LSMs.

   Supporting multiple xattrs is not currently supported where
   security_old_inode_init_security() was called (mknod, symlink), as it
   requires non-trivial changes that can be done at a later time. Like for
   reiserfs, even if EVM is invoked, it will not provide an xattr (if it is
   not the first to set it, its xattr will be discarded; if it is the first=
,
   it does not have xattrs to calculate the HMAC on).

   Finally, since security_inode_init_security(), unlike
   security_old_inode_init_security(), returns zero instead of -EOPNOTSUPP =
if
   no xattrs were provided by LSMs or if inodes are private, additionally
   check in ocfs2_init_security_get() if the xattr name is set.

   If not, act as if security_old_inode_init_security() returned -EOPNOTSUP=
P,
   and set si->enable to zero to notify to the functions following
   ocfs2_init_security_get() that no xattrs are available.

   Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
   Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
   Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
   Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
   Signed-off-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
