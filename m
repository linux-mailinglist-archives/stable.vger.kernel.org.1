Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1527909D3
	for <lists+stable@lfdr.de>; Sat,  2 Sep 2023 23:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbjIBVzV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 2 Sep 2023 17:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjIBVzU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 2 Sep 2023 17:55:20 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDFDCDB
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 14:55:17 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-34deab8010dso1124975ab.3
        for <stable@vger.kernel.org>; Sat, 02 Sep 2023 14:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693691717; x=1694296517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wl3WL1+D82VCAunVNz90Lcc+xqxrWzcYmCqBkjSr5Y8=;
        b=YlW14kuUjNoocGiXPW5f7cveezFayjKkfzah0M3MIGa6NDq6xMjoau4Vl8/hypcWAO
         xgr7982yD6sV1pRefMcIvOdTSwpAt6RaF3Grtm00q4EA6rt3GUZ8NzBPNWtbiQPbOZEK
         U7olvgsHRsNYRryc6u1jyzdd1yBauA5Xx0mUvGNZup0KhQgluZ7ahajcT5HuqN2uDE/a
         PX6ucLpjZ3uu1ULGggo6mXsIJALHMXwTRFvv2Pf2Is9W8qaIDExiB43c/EqUWC+0WxKW
         eMZv6Kw7Q5NSvQTg0ayNaP0mqDIuRgxfCsPO04nMSjBkv4BZi6q+WKbgLhqMz7jiQIxp
         ZobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693691717; x=1694296517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wl3WL1+D82VCAunVNz90Lcc+xqxrWzcYmCqBkjSr5Y8=;
        b=ezYQs+/i7Bl/wreuhpvbYPBudc3qg5hQ8SL+EwNAwT4U+AHvpZc/TAWQV/RFcRqyGV
         v/XWAl9s16/4Ln9QAqKG8e9evOVTdNAwkBQVD6stVLKO1fY00Q2pUUrcZx0+dOYbMKK6
         Bj9E1C5zq9JIj2MLscEbOjiR47oeIxYLZny+mRt72bI6uc6oqkMdielxug8Jfyk5sNWg
         D68RhLx8l/gsryoYzly83OsV2N12XWJh+4ONEB+LGlqsDFyNKkwzLi2w3YstqKNZ231u
         4kfn8VUdGcAl/HXHokkj2K28gtFfzJKF+9M35OV3j6hPUR8or0R+RZO2vnpUM5CbCmen
         sHvA==
X-Gm-Message-State: AOJu0YxkfCPE+cdt9VzpLb2bOjAtT2U0NCbg7ASA5zKLSKsxbSRdH8fX
        p1h2JcOdiO9Fzvp+aC+C9tTc0MqzovNho7QXQRY=
X-Google-Smtp-Source: AGHT+IHUeblH309/UU0CB8IwnNSgxhe/XTE4op5xVUeyxDvfj27AI24obcfZYLoTttjpyWNiPiqgdg==
X-Received: by 2002:a05:6e02:1b82:b0:34a:c61f:9e99 with SMTP id h2-20020a056e021b8200b0034ac61f9e99mr7498444ili.9.1693691716958;
        Sat, 02 Sep 2023 14:55:16 -0700 (PDT)
Received: from westworld (209-147-138-147.nat.asu.edu. [209.147.138.147])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902f7c500b001b89536974bsm5053876plw.202.2023.09.02.14.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 14:55:16 -0700 (PDT)
Date:   Sat, 2 Sep 2023 14:55:14 -0700
From:   Kyle Zeng <zengyhkyle@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc:     sishuai@purdue.edu, hch@lst.de
Subject: Re: [PATCH] configfs: fix a race in configfs_lookup()
Message-ID: <ZPOvQjsauIgSik3k@westworld>
References: <ZPOZFHHA0abVmGx+@westworld>
 <2023090247-sneezing-latch-af81@gregkh>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Uf+JOetOVng3POdo"
Content-Disposition: inline
In-Reply-To: <2023090247-sneezing-latch-af81@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--Uf+JOetOVng3POdo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> You lost all the original signed-off-by lines of the original, AND you
> lost the authorship of the original commit.  And you didn't cc: anyone
> involved in the original patch, to get their review, or objection to it
> being backported.
Sorry for the rookie mistakes. I drafted another version and it is
attached to the email. Can you please check whether it is OK?

> Also, how did you test this change?  is this something that you have
> actually hit in real life?
Yes. I encountered this when testing the latest v5.10.y branch. A
minimal proof-of-concept code looks like this:
~~~
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>

int main(void)
{
	int fd = open("/sys/kernel/config", 0);

	if(!fork()) {
		while(1) lseek(fd, SEEK_CUR, 1);
	}
	while(1) unlinkat(fd, "file", 0);

	return 0;
}
~~~

--Uf+JOetOVng3POdo
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-configfs-fix-a-race-in-configfs_lookup.patch"

From 366d165e876a14a5b25ad741fdcd8658aa7e690d Mon Sep 17 00:00:00 2001
From: Kyle Zeng <zengyhkyle@gmail.com>
Date: Fri, 1 Sep 2023 17:41:14 -0700
Subject: [PATCH v5.10.y] configfs: fix a race in configfs_lookup()

commit c42dd069be8dfc9b2239a5c89e73bbd08ab35de0 upstream.

configfs: fix a race in configfs_lookup()
When configfs_lookup() is executing list_for_each_entry(),
it is possible that configfs_dir_lseek() is calling list_del().
Some unfortunate interleavings of them can cause a kernel NULL
pointer dereference error

Thread 1                  Thread 2
//configfs_dir_lseek()    //configfs_lookup()
list_del(&cursor->s_sibling);
                         list_for_each_entry(sd, ...)

Fix this by grabbing configfs_dirent_lock in configfs_lookup()
while iterating ->s_children.

Signed-off-by: Sishuai Gong <sishuai@purdue.edu>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kyle Zeng <zengyhkyle@gmail.com>
---
Please apply this patch to v5.10.y. This patch adapts the original patch
to v5.10.y considering codebase change.
The idea is to hold the configfs_dirent_lock when traversing
->s_children, which follows the core idea of the original patch.

This patch has been tested against the v5.10.y stable tree.

 fs/configfs/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 12388ed4faa5..0b7e9ab517d5 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -479,6 +479,7 @@ static struct dentry * configfs_lookup(struct inode *dir,
 	if (!configfs_dirent_is_ready(parent_sd))
 		goto out;
 
+	spin_lock(&configfs_dirent_lock);
 	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
 		if (sd->s_type & CONFIGFS_NOT_PINNED) {
 			const unsigned char * name = configfs_get_name(sd);
@@ -491,6 +492,7 @@ static struct dentry * configfs_lookup(struct inode *dir,
 			break;
 		}
 	}
+	spin_unlock(&configfs_dirent_lock);
 
 	if (!found) {
 		/*
-- 
2.34.1


--Uf+JOetOVng3POdo--
