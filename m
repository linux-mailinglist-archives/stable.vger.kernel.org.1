Return-Path: <stable+bounces-23828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5167C868A07
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 08:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCBFB1F2255B
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 07:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8140D54BC8;
	Tue, 27 Feb 2024 07:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXl0bpqd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879A054F83
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 07:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709019667; cv=none; b=InJoOiSO4RY7OOivL3QBPTeO8ol6WD76XwfBsGmTah+wwQ0K82IA/Gc+UdpAVjZBGRuEz/omUaEtpima+JwJUvgMPh5TqqojFs3PVvj/ufF14wT40QDH0CPTY0Lug2YI1mPwIe32IYNMy+IeFx4SVh9JKOOjgQUnoD9dvz3UhCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709019667; c=relaxed/simple;
	bh=LjFchqJ7fv2J9plCbbCUU0+zyPgd1lGSFkzPwOj7oL0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LSGLa07XiQiP2P2IT+/Mg+4Dpg3dZnUGqWRcwKeMixmQusmoeOO+XDfV5Q07HBN9zXcNKYpCQtVE3Y6L0jhRxZdlnG9DpTx0gTiD3QHJYPTRzOcnJyCok3ktLIOR+NCVAUiIAOMlXr2a1esKL6yYh8tJkPlQeGF9WR1RdgobPYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXl0bpqd; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dbd32cff0bso29105545ad.0
        for <stable@vger.kernel.org>; Mon, 26 Feb 2024 23:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709019665; x=1709624465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92+2TageH+FXGPhCUqujdzhw6qx31aFaK8t168mlTs0=;
        b=lXl0bpqdrtdwSIMXCfWN5ns5lR9LDWUaZKVKITZ66AYJYBN7WSl12wHGlmPeH33/WX
         c4D66OnAmVaY0XdVoerqZg7ekt801kcbYRDdjJz0uEYzY8ORSP35E8XoccDwB3tNO0vg
         LFfFppYrxzXixyGzeJvMIbcEcBaPf+xkH/WLbmRXkZqV4pa71XEQuAOV2cQR46N+b35Z
         dtqlQTJYTm5t5Oalh7Vbnp2LxOm4tUvvnYyYoAPG64Y1y8QeQKUh/qIguaGOXkUE1RT2
         EyTeoFGOwTfOXpGkW+uVh/VQRe+3n1fEE9Pt2X45sGHhymNE/HICdhoD+iyKAMMsnwzq
         USyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709019665; x=1709624465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92+2TageH+FXGPhCUqujdzhw6qx31aFaK8t168mlTs0=;
        b=IeG9e0awJQOgW4GJzu4m5LJLVXtJ67ClYjQ2O3+98Q4ofuULdgShYaLzmk64UxOWoD
         wQVUlTTF8EeHN1s2spqsNIDhQ9ZJRMzmEfLy+y4XyrvaY+zFktzoxbzXMObNXywuBmwM
         GeXAsAWDs8qFTj6Dc659lNTbLXM2GGINzYjpyC+O+ChnFFTcqSDN55B6dpRMBRIYm4ky
         G4a48DON76T3oa//K0r/2D+6LRxaN7v2EVo3XCjnXq8R4rXqfBYoqnkZqUiDGJ2CS5l0
         jORLDQ9ofVveZuI7zgpLSQJsn+Oao8ZLWxyNTTefYZDNg2uWuGThQZmXF9RtbTHkskzN
         mxsQ==
X-Gm-Message-State: AOJu0Yz6AGyEIjKjMJCPpH6nZkJpZ+XbKJkQLZtqfcxqkRyeHnaabwzB
	z4HAOs32WG2Wj5xilmJh1OlcsGGJ0Tw5MMcwpXxB0/+QuG0rxWSyLp8R7Wo1nlm8xQ==
X-Google-Smtp-Source: AGHT+IGf9sMePHBxGTwQUOjRzd4Is4ynyjVANJdI0djeLhvJxopu5kQmD6jpIJ0tB7YYiUVeOn4UbQ==
X-Received: by 2002:a17:903:2281:b0:1d9:ce46:6ebd with SMTP id b1-20020a170903228100b001d9ce466ebdmr10851750plh.16.1709019664319;
        Mon, 26 Feb 2024 23:41:04 -0800 (PST)
Received: from localhost ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id l11-20020a17090270cb00b001dcc0d35018sm181197plt.112.2024.02.26.23.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 23:41:04 -0800 (PST)
Date: Tue, 27 Feb 2024 15:40:57 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org,
 linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com, Yue Hu
 <huyue2@coolpad.com>
Subject: Re: [PATCH 6.1.y 1/2] erofs: simplify compression configuration
 parser
Message-ID: <20240227153951.00000e5e.zbestahu@gmail.com>
In-Reply-To: <80740042-8b16-40f6-b0a2-4e53670d6513@linux.alibaba.com>
References: <5216b503054dbbb9fccf8faa280647c728e82726.1709000322.git.huyue2@coolpad.com>
	<80740042-8b16-40f6-b0a2-4e53670d6513@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Feb 2024 11:00:01 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Hi Yue,
> 
> On 2024/2/27 10:22, Yue Hu wrote:
> > From: Gao Xiang <hsiangkao@linux.alibaba.com>
> > 
> > [ Upstream commit efb4fb02cef3ab410b603c8f0e1c67f61d55f542 ]
> > 
> > Move erofs_load_compr_cfgs() into decompressor.c as well as introduce
> > a callback instead of a hard-coded switch for each algorithm for
> > simplicity.
> > 
> > Reviewed-by: Chao Yu <chao@kernel.org>
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > Link: https://lore.kernel.org/r/20231022130957.11398-1-xiang@kernel.org
> > Stable-dep-of: 118a8cf504d7 ("erofs: fix inconsistent per-file compression format")
> > Signed-off-by: Yue Hu <huyue2@coolpad.com>  
> 
> where is the real fix [patch 2/2]? It's needed to be posted
> here too.

Already sent.

> 
> Thanks,
> Gao Xiang
> 
> > ---
> >   fs/erofs/compress.h          |  4 ++
> >   fs/erofs/decompressor.c      | 60 ++++++++++++++++++++++++++++--
> >   fs/erofs/decompressor_lzma.c |  4 +-
> >   fs/erofs/internal.h          | 28 ++------------
> >   fs/erofs/super.c             | 72 +++++-------------------------------
> >   5 files changed, 76 insertions(+), 92 deletions(-)
> > 
> > diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
> > index 26fa170090b8..c4a3187bdb8f 100644
> > --- a/fs/erofs/compress.h
> > +++ b/fs/erofs/compress.h
> > @@ -21,6 +21,8 @@ struct z_erofs_decompress_req {
> >   };
> >   
> >   struct z_erofs_decompressor {
> > +	int (*config)(struct super_block *sb, struct erofs_super_block *dsb,
> > +		      void *data, int size);
> >   	int (*decompress)(struct z_erofs_decompress_req *rq,
> >   			  struct page **pagepool);
> >   	char *name;
> > @@ -93,6 +95,8 @@ int z_erofs_decompress(struct z_erofs_decompress_req *rq,
> >   		       struct page **pagepool);
> >   
> >   /* prototypes for specific algorithms */
> > +int z_erofs_load_lzma_config(struct super_block *sb,
> > +			struct erofs_super_block *dsb, void *data, int size);
> >   int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
> >   			    struct page **pagepool);
> >   #endif
> > diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> > index 0cfad74374ca..ae3cfd018d99 100644
> > --- a/fs/erofs/decompressor.c
> > +++ b/fs/erofs/decompressor.c
> > @@ -24,11 +24,11 @@ struct z_erofs_lz4_decompress_ctx {
> >   	unsigned int oend;
> >   };
> >   
> > -int z_erofs_load_lz4_config(struct super_block *sb,
> > -			    struct erofs_super_block *dsb,
> > -			    struct z_erofs_lz4_cfgs *lz4, int size)
> > +static int z_erofs_load_lz4_config(struct super_block *sb,
> > +			    struct erofs_super_block *dsb, void *data, int size)
> >   {
> >   	struct erofs_sb_info *sbi = EROFS_SB(sb);
> > +	struct z_erofs_lz4_cfgs *lz4 = data;
> >   	u16 distance;
> >   
> >   	if (lz4) {
> > @@ -374,17 +374,71 @@ static struct z_erofs_decompressor decompressors[] = {
> >   		.name = "interlaced"
> >   	},
> >   	[Z_EROFS_COMPRESSION_LZ4] = {
> > +		.config = z_erofs_load_lz4_config,
> >   		.decompress = z_erofs_lz4_decompress,
> >   		.name = "lz4"
> >   	},
> >   #ifdef CONFIG_EROFS_FS_ZIP_LZMA
> >   	[Z_EROFS_COMPRESSION_LZMA] = {
> > +		.config = z_erofs_load_lzma_config,
> >   		.decompress = z_erofs_lzma_decompress,
> >   		.name = "lzma"
> >   	},
> >   #endif
> >   };
> >   
> > +int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
> > +{
> > +	struct erofs_sb_info *sbi = EROFS_SB(sb);
> > +	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> > +	unsigned int algs, alg;
> > +	erofs_off_t offset;
> > +	int size, ret = 0;
> > +
> > +	if (!erofs_sb_has_compr_cfgs(sbi)) {
> > +		sbi->available_compr_algs = Z_EROFS_COMPRESSION_LZ4;
> > +		return z_erofs_load_lz4_config(sb, dsb, NULL, 0);
> > +	}
> > +
> > +	sbi->available_compr_algs = le16_to_cpu(dsb->u1.available_compr_algs);
> > +	if (sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS) {
> > +		erofs_err(sb, "unidentified algorithms %x, please upgrade kernel",
> > +			  sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS);
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	offset = EROFS_SUPER_OFFSET + sbi->sb_size;
> > +	alg = 0;
> > +	for (algs = sbi->available_compr_algs; algs; algs >>= 1, ++alg) {
> > +		void *data;
> > +
> > +		if (!(algs & 1))
> > +			continue;
> > +
> > +		data = erofs_read_metadata(sb, &buf, &offset, &size);
> > +		if (IS_ERR(data)) {
> > +			ret = PTR_ERR(data);
> > +			break;
> > +		}
> > +
> > +		if (alg >= ARRAY_SIZE(decompressors) ||
> > +		    !decompressors[alg].config) {
> > +			erofs_err(sb, "algorithm %d isn't enabled on this kernel",
> > +				  alg);
> > +			ret = -EOPNOTSUPP;
> > +		} else {
> > +			ret = decompressors[alg].config(sb,
> > +					dsb, data, size);
> > +		}
> > +
> > +		kfree(data);
> > +		if (ret)
> > +			break;
> > +	}
> > +	erofs_put_metabuf(&buf);
> > +	return ret;
> > +}
> > +
> >   int z_erofs_decompress(struct z_erofs_decompress_req *rq,
> >   		       struct page **pagepool)
> >   {
> > diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
> > index 49addc345aeb..970464c4b676 100644
> > --- a/fs/erofs/decompressor_lzma.c
> > +++ b/fs/erofs/decompressor_lzma.c
> > @@ -72,10 +72,10 @@ int z_erofs_lzma_init(void)
> >   }
> >   
> >   int z_erofs_load_lzma_config(struct super_block *sb,
> > -			     struct erofs_super_block *dsb,
> > -			     struct z_erofs_lzma_cfgs *lzma, int size)
> > +			struct erofs_super_block *dsb, void *data, int size)
> >   {
> >   	static DEFINE_MUTEX(lzma_resize_mutex);
> > +	struct z_erofs_lzma_cfgs *lzma = data;
> >   	unsigned int dict_size, i;
> >   	struct z_erofs_lzma *strm, *head = NULL;
> >   	int err;
> > diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> > index d8d09fc3ed65..79a7a5815ea6 100644
> > --- a/fs/erofs/internal.h
> > +++ b/fs/erofs/internal.h
> > @@ -471,6 +471,8 @@ struct erofs_map_dev {
> >   
> >   /* data.c */
> >   extern const struct file_operations erofs_file_fops;
> > +void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
> > +			  erofs_off_t *offset, int *lengthp);
> >   void erofs_unmap_metabuf(struct erofs_buf *buf);
> >   void erofs_put_metabuf(struct erofs_buf *buf);
> >   void *erofs_bread(struct erofs_buf *buf, struct inode *inode,
> > @@ -565,9 +567,7 @@ void z_erofs_exit_zip_subsystem(void);
> >   int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
> >   				       struct erofs_workgroup *egrp);
> >   int erofs_try_to_free_cached_page(struct page *page);
> > -int z_erofs_load_lz4_config(struct super_block *sb,
> > -			    struct erofs_super_block *dsb,
> > -			    struct z_erofs_lz4_cfgs *lz4, int len);
> > +int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb);
> >   #else
> >   static inline void erofs_shrinker_register(struct super_block *sb) {}
> >   static inline void erofs_shrinker_unregister(struct super_block *sb) {}
> > @@ -575,36 +575,14 @@ static inline int erofs_init_shrinker(void) { return 0; }
> >   static inline void erofs_exit_shrinker(void) {}
> >   static inline int z_erofs_init_zip_subsystem(void) { return 0; }
> >   static inline void z_erofs_exit_zip_subsystem(void) {}
> > -static inline int z_erofs_load_lz4_config(struct super_block *sb,
> > -				  struct erofs_super_block *dsb,
> > -				  struct z_erofs_lz4_cfgs *lz4, int len)
> > -{
> > -	if (lz4 || dsb->u1.lz4_max_distance) {
> > -		erofs_err(sb, "lz4 algorithm isn't enabled");
> > -		return -EINVAL;
> > -	}
> > -	return 0;
> > -}
> >   #endif	/* !CONFIG_EROFS_FS_ZIP */
> >   
> >   #ifdef CONFIG_EROFS_FS_ZIP_LZMA
> >   int z_erofs_lzma_init(void);
> >   void z_erofs_lzma_exit(void);
> > -int z_erofs_load_lzma_config(struct super_block *sb,
> > -			     struct erofs_super_block *dsb,
> > -			     struct z_erofs_lzma_cfgs *lzma, int size);
> >   #else
> >   static inline int z_erofs_lzma_init(void) { return 0; }
> >   static inline int z_erofs_lzma_exit(void) { return 0; }
> > -static inline int z_erofs_load_lzma_config(struct super_block *sb,
> > -			     struct erofs_super_block *dsb,
> > -			     struct z_erofs_lzma_cfgs *lzma, int size) {
> > -	if (lzma) {
> > -		erofs_err(sb, "lzma algorithm isn't enabled");
> > -		return -EINVAL;
> > -	}
> > -	return 0;
> > -}
> >   #endif	/* !CONFIG_EROFS_FS_ZIP */
> >   
> >   /* flags for erofs_fscache_register_cookie() */
> > diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> > index bd8bf8fc2f5d..f2647126cb2f 100644
> > --- a/fs/erofs/super.c
> > +++ b/fs/erofs/super.c
> > @@ -126,8 +126,8 @@ static bool check_layout_compatibility(struct super_block *sb,
> >   
> >   #ifdef CONFIG_EROFS_FS_ZIP
> >   /* read variable-sized metadata, offset will be aligned by 4-byte */
> > -static void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
> > -				 erofs_off_t *offset, int *lengthp)
> > +void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
> > +			  erofs_off_t *offset, int *lengthp)
> >   {
> >   	u8 *buffer, *ptr;
> >   	int len, i, cnt;
> > @@ -159,64 +159,15 @@ static void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
> >   	}
> >   	return buffer;
> >   }
> > -
> > -static int erofs_load_compr_cfgs(struct super_block *sb,
> > -				 struct erofs_super_block *dsb)
> > -{
> > -	struct erofs_sb_info *sbi = EROFS_SB(sb);
> > -	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
> > -	unsigned int algs, alg;
> > -	erofs_off_t offset;
> > -	int size, ret = 0;
> > -
> > -	sbi->available_compr_algs = le16_to_cpu(dsb->u1.available_compr_algs);
> > -	if (sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS) {
> > -		erofs_err(sb, "try to load compressed fs with unsupported algorithms %x",
> > -			  sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS);
> > -		return -EINVAL;
> > -	}
> > -
> > -	offset = EROFS_SUPER_OFFSET + sbi->sb_size;
> > -	alg = 0;
> > -	for (algs = sbi->available_compr_algs; algs; algs >>= 1, ++alg) {
> > -		void *data;
> > -
> > -		if (!(algs & 1))
> > -			continue;
> > -
> > -		data = erofs_read_metadata(sb, &buf, &offset, &size);
> > -		if (IS_ERR(data)) {
> > -			ret = PTR_ERR(data);
> > -			break;
> > -		}
> > -
> > -		switch (alg) {
> > -		case Z_EROFS_COMPRESSION_LZ4:
> > -			ret = z_erofs_load_lz4_config(sb, dsb, data, size);
> > -			break;
> > -		case Z_EROFS_COMPRESSION_LZMA:
> > -			ret = z_erofs_load_lzma_config(sb, dsb, data, size);
> > -			break;
> > -		default:
> > -			DBG_BUGON(1);
> > -			ret = -EFAULT;
> > -		}
> > -		kfree(data);
> > -		if (ret)
> > -			break;
> > -	}
> > -	erofs_put_metabuf(&buf);
> > -	return ret;
> > -}
> >   #else
> > -static int erofs_load_compr_cfgs(struct super_block *sb,
> > -				 struct erofs_super_block *dsb)
> > +static int z_erofs_parse_cfgs(struct super_block *sb,
> > +			      struct erofs_super_block *dsb)
> >   {
> > -	if (dsb->u1.available_compr_algs) {
> > -		erofs_err(sb, "try to load compressed fs when compression is disabled");
> > -		return -EINVAL;
> > -	}
> > -	return 0;
> > +	if (!dsb->u1.available_compr_algs)
> > +		return 0;
> > +
> > +	erofs_err(sb, "compression disabled, unable to mount compressed EROFS");
> > +	return -EOPNOTSUPP;
> >   }
> >   #endif
> >   
> > @@ -398,10 +349,7 @@ static int erofs_read_superblock(struct super_block *sb)
> >   	}
> >   
> >   	/* parse on-disk compression configurations */
> > -	if (erofs_sb_has_compr_cfgs(sbi))
> > -		ret = erofs_load_compr_cfgs(sb, dsb);
> > -	else
> > -		ret = z_erofs_load_lz4_config(sb, dsb, NULL, 0);
> > +	ret = z_erofs_parse_cfgs(sb, dsb);
> >   	if (ret < 0)
> >   		goto out;
> >     


