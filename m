Return-Path: <stable+bounces-215686-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BYDFd1ui2lhUQAAu9opvQ
	(envelope-from <stable+bounces-215686-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 18:46:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CC611E103
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 18:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 847713040216
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 17:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B459F2D0601;
	Tue, 10 Feb 2026 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QfyN6Nk0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uHm3KmVX"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA9035DCED
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770745547; cv=none; b=cQ2ipSkm9xSQAX4f6em0DajxA+elhaezbM+btAO6QKsr/6vcGTJ18foWYgcUXy3BITbT8RNgg9nGdkkredNzLXGo23W3MZoEijTIsLBprd9CVrOQ5+LluoLVff4uS4o9KEDSnYwkqOPcKsgl3nRGCTWYF1wqUBcI6kjjTDmSgKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770745547; c=relaxed/simple;
	bh=CPkvK7XkxBtLfxrYYEVvyrGgJ1BgYqj5KCtOpBrIFu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kseGE7cTuK3bieuIIjXmZANUDxmohWL5nOxtOxnkz9Lis24WxL+aWsAym+G4gtgs9dW8cEpYvblDhi+8kiOsaLlhj/NP1zF8gSq09QUXt7Y9TYnc4fp0++My20PyK2yV+fxXWHa6CnjogcPG5q+g7hsvzzjY0vxnECRgiVsqFhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QfyN6Nk0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uHm3KmVX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770745545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v97i6pXJR3OS2M9QPJY31R/eAhpPw43HPcZzC/bD1aM=;
	b=QfyN6Nk0XFVn1RhRcDP9F44sEaj8IubQYq0djS39niI5eoOEladEnWaN1GGmXqSxEXfS21
	oyouFMZ2PRt+5r1rIpnYgYXImMz+oCUE/mL5ISJOBc4OviD1VXVJMgD6L9+gOsREQwXzzL
	6GZQt9En3Uy2JM5ql/VSqzYjtcvYRxU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-DGjj1BMGNqqP4zUqw0zHxA-1; Tue, 10 Feb 2026 12:45:44 -0500
X-MC-Unique: DGjj1BMGNqqP4zUqw0zHxA-1
X-Mimecast-MFC-AGG-ID: DGjj1BMGNqqP4zUqw0zHxA_1770745543
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-435ab9ed85dso2821126f8f.1
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 09:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770745543; x=1771350343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v97i6pXJR3OS2M9QPJY31R/eAhpPw43HPcZzC/bD1aM=;
        b=uHm3KmVX6WwNf0mll+cqSiNej64+aaQoC+ht46IFRxbO+jdxRisHW7hMyZPZOBBfmD
         beTu2/NF5VMhSWcZQFk/LEt6VfYb/0psKf5/8H26IwZQXY57Q/hmG6h3Aq9spWGf1lZs
         5u7O1skcUJCarvdJlOsqoXP6WlGb9yD4pT2h+dXJjjsfHbXm8nJ/O7wu5j7QaIda0Rve
         W8+wqWdl3kVFNmazswiR4EIgnF2LlESRisPBiu8pJkeucVTgsZemRELHT1uPzrEFy2ed
         803bAzKZEh2Dibf1EWPh1ZE2DFfageB3FNvONY8R6+ZuwgEN4B3Nl+Kqg/2M3wNf/pFc
         N/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770745543; x=1771350343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v97i6pXJR3OS2M9QPJY31R/eAhpPw43HPcZzC/bD1aM=;
        b=YdjHYtUKvNkMQQL1IF7oNYmDUbcxS4YCXEJN8GHaHnEyIGYGg7S6xwRMUz8Ml+Fkz9
         KyAtfhd8VMrRExPBGcHx7LEns8UPcK9IH6jO5rUkqOHxK0h/CMJ783u3MTnYKkg9dXve
         NHLf2JiqitUAx7eaw7fquZM0INbDbH01b7iWBNkL/sgqLISOGqkyh4td3y+X8ZhhaU+F
         ET7HYU1PX3t+tQpfpTbP2EQ2JFpqUyjCZubE0GyEYBuScv8PywISXK1+G7icjbF94AN3
         mvAKQBOp3fdPlRrEvLMgVg1Mr/d3f8MeCuGeXsbSHy2UDfS2GR6rdf/TfryIEJHiI2l4
         MIxA==
X-Forwarded-Encrypted: i=1; AJvYcCWhMeOq7rHFwtD29eg2NoLPhFSrJdCRvs/EhLD6UT6o+J37VQ8q20KcFhQOaDGGJqr6Lo0PPzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxId8t5YpVEQBJoLfJLswxlw+pUHn/bn38nixlLDf5crs1meUXa
	M/9YBbaMY6LCcME9+u5NRbi07kmFNQCQ7/ck+WryyLwb97oLzts9x51Qn84uZEjinCUqqvylV1z
	sGmXD/gNhWuvFCTI+QmuZAqxxi1Di/9ILu0hNcuj2yinxFY2a2AMagCwH
X-Gm-Gg: AZuq6aJkCj20iXx32klvdTD7V+v2LZTsBCPVmFSYcUDE81HavXuKwL4iw1OnR1PK/E4
	qJGf2ree52Y2DfG32jx11OcBTpbt8DXo6XTFsflLYeQ6PwTKiPiNfDTNXfc0I1WSFrcgykMVmnd
	nkxWWlPm5BzTXw9QuIMqkiwS9JrDVcZ2lmbU14+2VIq/2fozvWJPwR3+miNY9p6HiBe385ZYIZS
	ZmRUMmy2uOdZxkbRMQho3NJbI3NEBPevE4NQqit1lESUxBm0kLVY+15gcXnR4DfR7KiQ8ml7VHy
	DLr21V98P/X+0dpBY16fLS3gtTo4mhIhNPNBHRTB7DgL9zwY+6e2vOECygktecNn5vWCZlUsNIg
	BabkEf0K3oTA=
X-Received: by 2002:a05:6000:1a42:b0:436:38a4:2423 with SMTP id ffacd0b85a97d-43638a42694mr13750882f8f.22.1770745542811;
        Tue, 10 Feb 2026 09:45:42 -0800 (PST)
X-Received: by 2002:a05:6000:1a42:b0:436:38a4:2423 with SMTP id ffacd0b85a97d-43638a42694mr13750844f8f.22.1770745542317;
        Tue, 10 Feb 2026 09:45:42 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376806626fsm22681690f8f.37.2026.02.10.09.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 09:45:41 -0800 (PST)
Date: Tue, 10 Feb 2026 18:45:40 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>, 
	linux-fsdevel@vger.kernel.org, syzbot+fa79520cb6cf363d660d@syzkaller.appspotmail.com, 
	Andrey Albershteyn <aalbersh@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] fs: set fsx_valid hint in file_getattr() syscall
Message-ID: <bc7dga4oxvoqevokdzffl25mh7uawx3rfvz5q2goyz4z76l65r@bp4vpjmzmbhk>
References: <20260210095042.506707-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210095042.506707-1-amir73il@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215686-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aalbersh@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,fa79520cb6cf363d660d];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 83CC611E103
X-Rspamd-Action: no action

On 2026-02-10 10:50:42, Amir Goldstein wrote:
> The vfs_fileattr_get() API is a unification of the two legacy ioctls
> FS_IOC_GETFLAGS and FS_IOC_FSGETXATTR.
> 
> The legacy ioctls set a hint flag, either flags_valid or fsx_valid,
> which overlayfs and fuse may use to convert back to one of the two
> legacy ioctls.
> 
> The new file_getattr() syscall is a modern version of the ioctl
> FS_IOC_FSGETXATTR, but it does not set the fsx_valid hint leading to
> uninit-value KMSAN warning in ovl_fileattr_get() as is also expected
> to happen in fuse_fileattr_get().
> 
> Reported-by: syzbot+fa79520cb6cf363d660d@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/698ad8b7.050a0220.3b3015.008b.GAE@google.com/
> Fixes: be7efb2d20d67 ("fs: introduce file_getattr and file_setattr syscalls")
> Cc: Andrey Albershteyn <aalbersh@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/file_attr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index 53b356dd8c33a..910c346d81bcd 100644
> --- a/fs/file_attr.c
> +++ b/fs/file_attr.c
> @@ -379,7 +379,7 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
>  	struct filename *name __free(putname) = NULL;
>  	unsigned int lookup_flags = 0;
>  	struct file_attr fattr;
> -	struct file_kattr fa;
> +	struct file_kattr fa = { .fsx_valid = true }; /* hint only */
>  	int error;
>  
>  	BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);
> -- 
> 2.52.0
> 

There's same patch a bit earlier from Edward
https://lore.kernel.org/linux-fsdevel/tencent_B6C4583771D76766D71362A368696EC3B605@qq.com/

Looks good to me
Reviewed-by: Andrey Albershteyn <aalbersh@kernel.org>

-- 
- Andrey


