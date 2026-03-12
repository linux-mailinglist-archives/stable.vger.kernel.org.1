Return-Path: <stable+bounces-224912-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBY7NmQbs2mDSAAAu9opvQ
	(envelope-from <stable+bounces-224912-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:00:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43945278678
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2B743156890
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 19:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804993BFE4B;
	Thu, 12 Mar 2026 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fGx99qZe"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E823B0AC1
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 19:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345539; cv=none; b=jt83knoNq9i2RHZinKLE4rhZdeWbyYOrZGTDL9+iNZoHeEJdPrzCaCIYMaBv2o65Gi/n4hJGb4ISzC6RKrL3X3gUs96janciJkzFfsV+KGvb0OIxV7nS19Y09AIxsiarSXxBLHYc05/RWdNyMBwJkpXtJjbHWik+6pmoGPYGL2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345539; c=relaxed/simple;
	bh=RY963B+uqTjMp7UVFZuiwEqIxn4cJaaQeDCKxuMpfzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSYNh7Dmmlno1S1pEfVRLrB3vWofBSAqDN1evUOYSmZWhTqWiAlyvm/D4k8kkvjLEayjPJXlOK6FFGrNNAmn3EMcmBKQdsAk3XvWcWcBNIowKlKJwhG7rQcMQBvrEJ3I+PVt4HHNnb1DElDOIBcgu3CpTEK/PVmtdeC5nNFSnQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fGx99qZe; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4853aec185aso12659755e9.1
        for <stable@vger.kernel.org>; Thu, 12 Mar 2026 12:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773345535; x=1773950335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MIAskK+ZNtzz1SwxyEcF/wj8vxB/luVLoRjKKyPZhTk=;
        b=fGx99qZewKXukzKKfUidwe0vteY3e84Pf3rZQYtlGSMbg5QKXqr5U9rzXM3Lk61D7V
         oh6y6i2n3FKatw1OtJ5HgZy9gsDyOiQXcJoRe0wy1dFc10GlwzJ9t41SF671R0TfOZLi
         XWLdndrot2+bhXIOnSdxLww3ouJCNGEZ724IkwxP2LzKH7T97gNbIseYw0Jhxk6rllw/
         XeM2ZEVFWvmC39qJK2d5wDALaATFLMujvgkxZd6OIfb9t9UWpd+Gq4qtNRi15rPp5204
         cCyw3fWxQ+k9Wl5CAmrC+vxXWKaTm9Gm2MryJHddIzlBHKIQVg/WTZIn9wdd923apvMJ
         s3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773345535; x=1773950335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MIAskK+ZNtzz1SwxyEcF/wj8vxB/luVLoRjKKyPZhTk=;
        b=P7rWLFyAo1nm6i97hSjM2qvt4SCuXpCaex33nSffVACziXA3tbxbpOpipX2IzGwwef
         X7Urwta079GII+SiV2PCJPNH3OnrHgnisjY9jVue9hhhSUHFp2l4fZk4YW9Dn42E0UEH
         Np7RtLAY3LclDUDjEaz9+DsxGdPTAHMQU5sYDWVB7DRW2ldVBOedz0ppbq18P5yM/VqF
         bUb7bS/StW2Za97LgGuZm37nQJI8niRRyx8jAv8WRURHk7O9d5nPXbfCVrKkd+kAL8tc
         Uv3RfoHLMbMjEvOUXZhwkLiR+afkEDK5Cus4zHC74vosPPRgPUXbcmlc/K4lwbp19/Pp
         liZg==
X-Forwarded-Encrypted: i=1; AJvYcCVZUFj/Z9IH5gVH0ZU4v3AToriXFBysY8AVJCX+59Hu85m2aA5+naLCEjMgGzL6EfhSFQoisAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdi2PWJDuoKUpqMdz91cYzy8aj4eQf7nwMSC2slih+pLR8xF9N
	mhioB2pg/e3dosvmxCYnFPCDniz7aGmBGT/woUjma/J12lviLzZbVyGb3DgKKzUcCXs=
X-Gm-Gg: ATEYQzxCDLv0ygodgbZOpGRig5aZTn+pbo+22RRyTuAhOAI8qnozJw3c55jxg90nKqr
	fANPfQTkj62VkURaYl1Ji3gpC2totZJMWyY8uouUDe1dmdbn15XrdtuXFC4s3scDCdYjJvNL+fG
	9KHGcavs+1uGHKuWy10zjxE3vk6eXTD1DxW9DwQySDp4z+It+wQb2EShWnWTJ5xzI3Yo8VOsImK
	3rf3YZ8MpI5JPYFcKePzMVarrHczwxDUetPk+23o5lI0CIKgIaW0NzTSNFHW/3py9Y4Di2UHqc/
	BUHyMpVd/FqE9gcJzu7hGIR01bnIA350dEGsphSvivSZGzQg2ecMKv7/Ra1r2G4agTONiA5grum
	yi8YCnPhWvlU4RYIk2cOl11IUJ6aWr7CyxD2RsCrNvhHicPpbyMk4kngWc9HVZMPPi37UK3lAYv
	to0Scno/mFGYImKQduVZ2+zBIgo/fz8zOktlmCN49pdscakACIDocLjAM=
X-Received: by 2002:a05:600c:c8d:b0:47e:e2ec:9947 with SMTP id 5b1f17b1804b1-4855671052dmr9527745e9.33.1773345534851;
        Thu, 12 Mar 2026 12:58:54 -0700 (PDT)
Received: from precision.tail0b5424.ts.net ([2804:7f0:6402:b103:6a0a:3e1c:778a:5cc7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be8aa96fdcsm7899078eec.30.2026.03.12.12.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 12:58:53 -0700 (PDT)
Date: Thu, 12 Mar 2026 16:58:49 -0300
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: nspmangalore@gmail.com
Cc: linux-cifs@vger.kernel.org, smfrench@gmail.com, pc@manguebit.com, 
	bharathsm@microsoft.com, dhowells@redhat.com, Shyam Prasad N <sprasad@microsoft.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] cifs: open files should not hold ref on superblock
Message-ID: <u4s57pxvrttksfxe5evylucarfoyiv3ut32d45nvfafsgmxtog@72x2iew66wrt>
References: <20260304124629.1616108-1-sprasad@microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304124629.1616108-1-sprasad@microsoft.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224912-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,manguebit.com,microsoft.com,redhat.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[henrique.carvalho@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Queue-Id: 43945278678
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 04, 2026 at 06:15:53PM +0530, nspmangalore@gmail.com wrote:
> From: Shyam Prasad N <sprasad@microsoft.com>
> 
> Today whenever we deal with a file, in addition to holding
> a reference on the dentry, we also get a reference on the
> superblock. This happens in two cases:
> 1. when a new cinode is allocated
> 2. when an oplock break is being processed
> 
> The reasoning for holding the superblock ref was to make sure
> that when umount happens, if there are users of inodes and
> dentries, it does not try to clean them up and wait for the
> last ref to superblock to be dropped by last of such users.
> 
> But the side effect of doing that is that umount silently drops
> a ref on the superblock and we could have deferred closes and
> lease breaks still holding these refs.
> 
> Ideally, we should ensure that all of these users of inodes and
> dentries are cleaned up at the time of umount, which is what this
> code is doing.
> 
> This code change allows these code paths to use a ref on the
> dentry (and hence the inode). That way, umount is
> ensured to clean up SMB client resources when it's the last
> ref on the superblock (For ex: when same objects are shared).
> 
> The code change also moves the call to close all the files in
> deferred close list to the umount code path. It also waits for
> oplock_break workers to be flushed before calling
> kill_anon_super (which eventually frees up those objects).
> 
> Fixes: 24261fc23db9 ("cifs: delay super block destruction until all cifsFileInfo objects are gone")
> Fixes: 705c79101ccf ("smb: client: fix use-after-free in cifs_oplock_break")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
> ---

Hi Shyam,

So the side effect of the previous code is that the umount hangs until
all the files are closed?

Thanks,

-- 
Henrique
SUSE Labs

