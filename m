Return-Path: <stable+bounces-271797-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SDTIGfrFR2o/fAAAu9opvQ
	(envelope-from <stable+bounces-271797-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 16:23:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C84703626
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 16:23:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=H2izTxoz;
	dkim=pass header.d=redhat.com header.s=google header.b=rFpAfVZA;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271797-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-271797-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8FFC530013BB
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 14:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1158C3DA5A0;
	Fri,  3 Jul 2026 14:12:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524523D9DBF
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 14:12:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783087966; cv=none; b=ZhPagrwG3xmA7g2kFHZ1YOAssMCSQmkey563a2awQd0SIyu7LOz1mHZC3+3BNCAxsBy6Bwo3ntauHZ+gE26dwaGTygmNI4h6uevzfISM5SUpZWagmv3UDOzjSW31zOr0D7oSjLzC7johw2k9NFoI2YO3bWddH5MDVgFfJQUF/tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783087966; c=relaxed/simple;
	bh=OAt/h6LcAZlSxDpYmMN2MII8fiusemJQ0zX2uNJgoGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P9IqE9eOsni2liHDOEsHLknDLV8LmsLoYDS9Ak2X/yNSJZ8sXciprWOqtFU+q2nxUbR7UXxzfwRRPQASYBIUqosa/ivb4MjV4XnzUCF821mZVeahGJmx18FTwoRUWncgJ98GS/lmivOicI6BELY73AzNyaUgoENdAzRHwsP6oS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H2izTxoz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rFpAfVZA; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783087964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9NS1dD+VotgGOcfz0tQuHB8qQ2ds5u4lyfKoRXnWkYw=;
	b=H2izTxoztL2CzeBgT7mi4/csmxHk+Nl2U3sDsWKdx0Hm+ybFhFXqz/D+tisCi7z1RmfORz
	K+lvHC1GVQcIt9b92eaG7PGf0qk2bexk4Un9Sa9vpYmM/pPT2Fa0CMz+KjNMmurgsYfBbb
	IK0NOWISuZVI9hjoDpuwnIkA4lvvuns=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-xOmrZvifPBuepqdGV3Nc5w-1; Fri, 03 Jul 2026 10:12:43 -0400
X-MC-Unique: xOmrZvifPBuepqdGV3Nc5w-1
X-Mimecast-MFC-AGG-ID: xOmrZvifPBuepqdGV3Nc5w_1783087962
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493c47a09b5so3884875e9.2
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 07:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783087962; x=1783692762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9NS1dD+VotgGOcfz0tQuHB8qQ2ds5u4lyfKoRXnWkYw=;
        b=rFpAfVZApezdnfqYj1iw3A/pPTNhfA3xz2od/Nr39JGY9ccE/MvYOBM/4CYZshPYqt
         ASrOrxbbgaeRyi/W5v3mCTncSPgvFwl03LUZ3fUlnz4FdzzxsS4r0D7g3+7LcWVcavHC
         timvHcRXLe1MwlBYKo1NI8+id0rZttKxpp2UivShFhn2Vo9FXCP16ItMj8bgEu9bKNXq
         1m1n0W4mLRxnNF/foEZdwH1s4+Vt2vgonGcPXdPBOqZuUdiKjJgFbdZV4rB6TIeGP2ZG
         2OaTa8VDS3EGlkjniPut3PawjOUyq1E6kUGD3FHnxVWI5FCMZg6HPQddJkPX2dbDjUNp
         hLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783087962; x=1783692762;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9NS1dD+VotgGOcfz0tQuHB8qQ2ds5u4lyfKoRXnWkYw=;
        b=fTrORR9jlTgtlERMmbUrYZDYQDd73FCagIDH3OHzqRoXcYITdIKQzj2hkEC1ZPOP+0
         8lR2YVBmQqxFUKlBnloHdqiaflDXLSz1Cb2JIVDtL41unHCOhU0jWJY3JyWXCkdi0BAc
         QARLsIePz2PXhCT0sU+IXi4dsWMorkYTYMgPcc5y4w9TD2fh+PZsUSaOyIjIhtky2VFj
         sDTfqetLwCLHgldcyqqw63GFVSqRtg1xU4iQ9X8388zG0CiIWuX799iS8cRY42DwCjL/
         Ne3AYWrdWNrNsd+mVP+hNpmMMpQXV/vsb6/dRd4pC+aubmQ2EYXqCHDiuZRNYbg1raf3
         zBlg==
X-Forwarded-Encrypted: i=1; AFNElJ8/AA3AvECfI9qVmnZcL9Js0HJZQ0PY5wldX8XxQrjKmW5bdDb/Q5xAHQfGoKeb6bXE80KvPjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0DIFmV3bl5t+JotUrPZjOZ6j7B0JTn3WHkmTdHsqEjMvFpWGW
	DrXPuME1Wdrkv/TIG0NPUo76gVdj2ZDdbZLimkyuz3IUKyygcgzMV9qMWX+KSgSAZ41ohXHvmiA
	NtqoxTGvRgJLxeqdkvU+uIbiiDtHUnujMcsn+Pwna6iM9n0vnOt1a32vHvQ==
X-Gm-Gg: AfdE7cnHo6pvbk5m5DwEKIG1MvvqSRzpV/e11SP+rsX0Ka/ShsOTAEBzsPTP5RlC1KM
	djpBUsiYIbmAiaww5CJU688eF6L15HUbPSGmacGN2rjwQC53c9HolK3AFXk6GTEQEGTmHpeCNUW
	gx9Ef/tZdH5eyU7w3jJ7B1u5Hd9Pi278TWD+xNVWIQcz2OfHgdkEAAiehE01p8fEBtGULfNvbNG
	TMkuJ3D9aCAvd/L9GdTZ9G5OrjQZD/uCMahRlm/NtxU/4ritldhEYhIMcngLQagugrcXr6Oo2zk
	tmk46dbRliZn0DgP9IUTF6NWRnQyEEhel1oSsIQ9a7/EUxrN3ioyE2354eZ1gZotw7nGxuiHWRV
	s5R0SWU90OVu5EjMcdme7g+AMsaCansQzWw8RGEWqI1Pnwc+YOrIIV+ubzI0VFdFx/+ychzCDQQ
	mRe7ti4XorMg==
X-Received: by 2002:a05:600c:5808:b0:492:4911:8a with SMTP id 5b1f17b1804b1-493d0f10382mr456105e9.12.1783087961915;
        Fri, 03 Jul 2026 07:12:41 -0700 (PDT)
X-Received: by 2002:a05:600c:5808:b0:492:4911:8a with SMTP id 5b1f17b1804b1-493d0f10382mr455835e9.12.1783087961477;
        Fri, 03 Jul 2026 07:12:41 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bef17c82sm141919575e9.1.2026.07.03.07.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 07:12:40 -0700 (PDT)
Message-ID: <477e46ec-24b1-4d3f-bbe7-347df18d5148@redhat.com>
Date: Fri, 3 Jul 2026 16:12:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bnx2x: fix null pointer dereference in
 bnx2x_free_mem_bp()
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>, skalluru@marvell.com
Cc: manishc@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org, stable@vger.kernel.org
References: <20260701065030.381836-1-nihaal@cse.iitm.ac.in>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260701065030.381836-1-nihaal@cse.iitm.ac.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271797-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nihaal@cse.iitm.ac.in,m:skalluru@marvell.com,m:manishc@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:horms@kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59C84703626

On 7/1/26 8:50 AM, Abdun Nihaal wrote:
> diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
> index 5b2640bd31c3..25ee45cb7f3f 100644
> --- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
> +++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
> @@ -4712,8 +4712,9 @@ void bnx2x_free_mem_bp(struct bnx2x *bp)
>  {
>  	int i;
>  
> -	for (i = 0; i < bp->fp_array_size; i++)
> -		kfree(bp->fp[i].tpa_info);
> +	if (bp->fp)
> +		for (i = 0; i < bp->fp_array_size; i++)
> +			kfree(bp->fp[i].tpa_info);

I think that a cleaner fix would be moving bp->fp_array_size
initialization after bp->fp.

/P


