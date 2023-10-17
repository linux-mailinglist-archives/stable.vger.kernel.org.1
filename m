Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A107CC863
	for <lists+stable@lfdr.de>; Tue, 17 Oct 2023 18:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbjJQQIO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 17 Oct 2023 12:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbjJQQIN (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Oct 2023 12:08:13 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E323B11A
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 09:08:04 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-3579ec224c9so1129065ab.1
        for <stable@vger.kernel.org>; Tue, 17 Oct 2023 09:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697558884; x=1698163684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PQEspDyUETHOCENd/vbOw9TSdpQYPdKVwc0QMpgogEw=;
        b=UZd2CBnMh/s8dAL1aZ5KR4Xho8LpokP+HR7jBD+VRtQcdrucX/8/M4HzYB3uqfZpVg
         4TwO/tyHQ7GShisLPlWyd4HFXdqIuyuvVCTpGjHtUk5Ay6Si6agyYCT91YCH3jIRJdHH
         7LbIOCvCMkXglIy6Ppwek6jMzK+QVlvCib70g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697558884; x=1698163684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQEspDyUETHOCENd/vbOw9TSdpQYPdKVwc0QMpgogEw=;
        b=Cz0s/sMV3hjldbTU4fNlN5rFS/1jzIBvzDqDAjZ6VXu2ket34ak8xgFJBbNQNQBS29
         DJnOn2pASEZKjORrR9Xi5T5SYR4QKCSCOiyoA48P5GV/lGAd7Gv74X2z2X+khD37S4cp
         thdi4ovo9ciodWp7oXbhiJpIqbzbkAPZRYelF96WjzttRPwUdWIDZCPItXSFSRpmA7M9
         +7uEYt21ehrQNb9Ffc5O0dtFbZ8p0QjHYqFqx50YKRAMByLiEBOU+vxcEQOCXw4FTdhT
         Exm9eYbo65VtPMAS2zK+QEbfkMOveWyG0hMIH4OiwZtiZMr187Caqk/dTG2sipTOcXP6
         OHHQ==
X-Gm-Message-State: AOJu0YzWMTDDF7HUcTAc9oAWR6Y+sbnkqBS5Sea82wFJDJ/lm3x7N896
        IX3NI206eqkxGtzs7OY+xb5OZw==
X-Google-Smtp-Source: AGHT+IGpNfeXMj6k+/Ml6Hira/lbpUM3mbbn1ZCv0G5NS6W0idxP6cjMqa4UEg10xKr9iVgu8C839Q==
X-Received: by 2002:a92:c70d:0:b0:348:b086:2c4b with SMTP id a13-20020a92c70d000000b00348b0862c4bmr2329326ilp.9.1697558884209;
        Tue, 17 Oct 2023 09:08:04 -0700 (PDT)
Received: from google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id t5-20020a02cca5000000b004290985a1efsm599551jap.43.2023.10.17.09.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:08:03 -0700 (PDT)
Date:   Tue, 17 Oct 2023 10:08:01 -0600
From:   Raul E Rangel <rrangel@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, Tim Bain <tbain@google.com>,
        Shuhei Takahashi <nya@chromium.org>
Subject: Re: [PATCH 6.4 041/737] ovl: Always reevaluate the file signature
 for IMA
Message-ID: <ZS6xYa_kjRGvdCG6@google.com>
References: <20230911134650.286315610@linuxfoundation.org>
 <20230911134651.582204417@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911134651.582204417@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Sep 11, 2023 at 03:38:20PM +0200, Greg Kroah-Hartman wrote:
> 6.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Eric Snowberg <eric.snowberg@oracle.com>
> 
> [ Upstream commit 18b44bc5a67275641fb26f2c54ba7eef80ac5950 ]
> 
> Commit db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version")
> partially closed an IMA integrity issue when directly modifying a file
> on the lower filesystem.  If the overlay file is first opened by a user
> and later the lower backing file is modified by root, but the extended
> attribute is NOT updated, the signature validation succeeds with the old
> original signature.
> 
> Update the super_block s_iflags to SB_I_IMA_UNVERIFIABLE_SIGNATURE to
> force signature reevaluation on every file access until a fine grained
> solution can be found.
> 

Sorry for replying to the 6.4-stable patch, I couldn't find the original
patch in the mailing list.

We recently upgraded from 6.4.4 to 6.5.3. We have the integrity LSM
enabled, and are using overlayfs. When we try and execute a binary from
the overlayfs filesystem, the integrity LSM hashes the binary and all
its shared objects every single invocation. This causes a serious
performance regression when invoking clang thousands of times while
building a package. We bisected the culprit down to this patch.

Here are some numbers:

With this patch + overlayfs:

	$ time /usr/bin/clang-17 --version > /dev/null 

	real	0m0.628s
	user	0m0.004s
	sys	0m0.624s
	$ time /usr/bin/clang-17 --version > /dev/null

	real	0m0.597s
	user	0m0.004s
	sys	0m0.593s

With this patch - overlayfs:

	$ truncate -s 1G foo.bin
	$ mkfs.ext4 foo.bin
	$ mount foo.bin /foo
	$ cp /usr/bin/clang-17 /foo
	$ time /foo/clang-17 --version > /dev/null

	real	0m0.040s
	user	0m0.009s
	sys	0m0.031s
	$ time /foo/clang-17 --version > /dev/null

	real	0m0.036s
	user	0m0.000s
	sys	0m0.037s

Without this path + overlayfs:
	$ time /usr/bin/clang-17 --version > /dev/null

	real	0m0.017s
	user	0m0.007s
	sys	0m0.011s
	$ time /usr/bin/clang-17 --version > /dev/null

	real	0m0.018s
	user	0m0.000s
	sys	0m0.018s

i.e., we go from ~30ms / invocation to 600ms / invocation. Building
glibc used to take about 3 minutes, but now its taking about 20 minutes.

Our clang binary is about 100 MiB in size.

Using `perf` the following sticks out:
	$ perf record -g time /usr/bin/clang-17 --version
	--92.03%--elf_map
	      vm_mmap_pgoff
	      ima_file_mmap
	      process_measurement
	      ima_collect_measurement
	      |
	       --91.95%--ima_calc_file_hash
	              ima_calc_file_hash_tfm
	              |
	              |--82.85%--_sha256_update
	              |     |
	              |      --82.47%--lib_sha256_base_do_update.isra.0
	              |           |
	              |            --82.39%--sha256_transform_rorx
	              |
	               --9.10%--integrity_kernel_read

The audit.log is also logging every clang invocation as well.

Was such a large performance regression expected? Can the commit be
reverted until the more fine grained solution mentioned in the commit
message be implemented?

Thanks,
Raul

> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/overlayfs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index ae1058fbfb5b2..8c60da7b4afd8 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -2052,7 +2052,7 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
>  		ovl_trusted_xattr_handlers;
>  	sb->s_fs_info = ofs;
>  	sb->s_flags |= SB_POSIXACL;
> -	sb->s_iflags |= SB_I_SKIP_SYNC;
> +	sb->s_iflags |= SB_I_SKIP_SYNC | SB_I_IMA_UNVERIFIABLE_SIGNATURE;
>  
>  	err = -ENOMEM;
>  	root_dentry = ovl_get_root(sb, upperpath.dentry, oe);
> -- 
> 2.40.1
> 
> 
> 
