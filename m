Return-Path: <stable+bounces-2772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784CA7FA55F
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 16:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33CB42817AF
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 15:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B4C347B8;
	Mon, 27 Nov 2023 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED3092;
	Mon, 27 Nov 2023 07:56:01 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3AEA31FD17;
	Mon, 27 Nov 2023 15:55:58 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 19DED13440;
	Mon, 27 Nov 2023 15:55:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id iKRPBg68ZGUQWgAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 27 Nov 2023 15:55:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5DF31A07CB; Mon, 27 Nov 2023 16:55:57 +0100 (CET)
Date: Mon, 27 Nov 2023 16:55:57 +0100
From: Jan Kara <jack@suse.cz>
To: Daniel =?utf-8?B?RMOtYXo=?= <daniel.diaz@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	jack@suse.cz, chrubis@suse.cz
Subject: Re: [PATCH 5.15 000/297] 5.15.140-rc1 review
Message-ID: <20231127155557.xv5ljrdxcfcigjfa@quack3>
References: <20231124172000.087816911@linuxfoundation.org>
 <81a11ebe-ea47-4e21-b5eb-536b1a723168@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81a11ebe-ea47-4e21-b5eb-536b1a723168@linaro.org>
X-Spamd-Bar: ++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [6.89 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(1.20)[suse.cz];
	 RCPT_COUNT_TWELVE(0.00)[20];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,sladewatkins.net,gmx.de,suse.cz];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 6.89
X-Rspamd-Queue-Id: 3AEA31FD17

Hello!

On Fri 24-11-23 23:45:09, Daniel D�az wrote:
> On 24/11/23 11:50 a.�m., Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.15.140 release.
> > There are 297 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.140-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> We are noticing a regression with ltp-syscalls' preadv03:

Thanks for report!

> -----8<-----
>   preadv03 preadv03
>   preadv03_64 preadv03_64
>   preadv03.c:102: TINFO: Using block size 512
>   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'a' expectedly
>   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'a' expectedly
>   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'b' expectedly
>   preadv03.c:102: TINFO: Using block size 512
>   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
>   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
>   preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
>   preadv03.c:102: TINFO: Using block size 512
>   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
>   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
>   preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
>   preadv03.c:102: TINFO: Using block size 512
>   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'a' expectedly
>   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'a' expectedly
>   preadv03.c:87: TPASS: preadv(O_DIRECT) read 512 bytes successfully with content 'b' expectedly
>   preadv03.c:102: TINFO: Using block size 512
>   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
>   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
>   preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
>   preadv03.c:102: TINFO: Using block size 512
>   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
>   preadv03.c:77: TFAIL: Buffer wrong at 0 have 62 expected 61
>   preadv03.c:66: TFAIL: preadv(O_DIRECT) read 0 bytes, expected 512
> ----->8-----
> 
> This is seen in the following environments:
> * dragonboard-845c
> * juno-64k_page_size
> * qemu-arm64
> * qemu-armv7
> * qemu-i386
> * qemu-x86_64
> * x86_64-clang
> 
> and on the following RC's:
> * v5.10.202-rc1
> * v5.15.140-rc1
> * v6.1.64-rc1

Hum, even in 6.1? That's odd. Can you please test whether current upstream
vanilla kernel works for you with this test? Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

