Return-Path: <stable+bounces-232948-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLaBJoYyzmkpmAYAu9opvQ
	(envelope-from <stable+bounces-232948-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 11:10:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5DE386886
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 11:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF90E3037460
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 09:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456CF311597;
	Thu,  2 Apr 2026 09:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8F7MFnp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RsMssBFu"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26DD3FBA7
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 09:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775120729; cv=none; b=QfGUIel+DZ5Srsny0C0LXF8meWTTRuZACWCXUgP9nFecQvHb6zt2igYhmQ23c6GaUg58PwBV4MPfNZNIVztYHLT5egXZOjXE3Yv68f904NXj2O5Z/lUTrSsVlcta+5uS3ECI80N/i16Kx0snYDCKhbYByiWYcYpnT4wABynlcHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775120729; c=relaxed/simple;
	bh=4xw/ga67voI/myNm1PvWwzm5TeuMOLMx8Q/7T61VA8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OF3eUwt/yxvSob6hLiMIcNe1WKsB1fpiTFzZE0w/Vms/ki9sasPa5upLiCtJGqPWDUuBxcx6oH1urbfSKF2UIg3NXamQFsARLZaqngG0f3iTOW+RD2V21BLCHgCMt+DKwxT31fVPD3YycsoO8pnN2s2MCVMZayquivOZzXoTLNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y8F7MFnp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RsMssBFu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775120727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uo3OmzGA2ckZBESUf6sgSBkAP6Pbi+eIBXMIiQ/bWFY=;
	b=Y8F7MFnpOxpSVQEghfc52b8ReBNa1r19g9ivtaVbOT2omWSWvZ3XGAPUOMXu8K0sa+QtNJ
	f98a3lKineIEMVx7ER04mKQ8XLL3qeLEoACQ8OX2fbk4YYPH0A9DvCyH0beoPL5IOj/RoC
	Ozy0km/MqPmqC3adgCWWLNnmV+t8Udg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-c9MH1egLPXewe6rbrkyCzw-1; Thu, 02 Apr 2026 05:05:25 -0400
X-MC-Unique: c9MH1egLPXewe6rbrkyCzw-1
X-Mimecast-MFC-AGG-ID: c9MH1egLPXewe6rbrkyCzw_1775120725
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48881eac1f2so3578915e9.0
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 02:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775120724; x=1775725524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uo3OmzGA2ckZBESUf6sgSBkAP6Pbi+eIBXMIiQ/bWFY=;
        b=RsMssBFuqL4139FKn9bVrWyvsHjQd9pteDE1m6lqSLGOwYb2K0LnMXYGiR2xxbBYLm
         UL/VqIVWF1N958otTstcT3uw+tprz1OUsZKzKoNUZ/UMtKaLb+AQ4v9SDBmxg/2iFn5f
         pCyGFer+hLd689fnpCopOPwhu/hsTdh09AbboOHYNaTJM/LVJyuSEDlbiwHZrWDp1VYY
         JRtjWT6D0LyAHqIiv6G13nZUTFMKPgaxJjTdwYGNgnAxQbmy1PPRyVN0KuPij9fRfaop
         VLMJY+IsnyemiMOTxg22krODGeRBQMoEJ3dR5O9O6HtG/1UrHK54UKPEtw0SxHUSUC38
         adjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775120724; x=1775725524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uo3OmzGA2ckZBESUf6sgSBkAP6Pbi+eIBXMIiQ/bWFY=;
        b=nbPlBOJcQhk0HRlwSMfaKWCMJ9ZdWQVaWDOnZ3mmXJY9m6Ya9c30LRbxvmCfoP9YgV
         nyEPdnfRMp9pRDhf8/7tk9QYpzHhT0QFH7cTZfeNdhd0mvk7Mjh4AOLCIuJ/B3yup6sm
         8DkPy0P0c+M33HW5h7EAImW/41wiyBucfyV25+MXSvZ9f6myGVZPVud1LFPBINWJKlHw
         8EFLSalcFw7aTWWZqZOlNLUGNPUtIZFR/cPx4yuds4RMehDqwuhvGOM2W53lauA3KH2C
         NUJelINkCC49z6pu8jhe/AxPWA/QH6nzXPT/XxxCml4uUjqTEjthUiiEit8Dh7NGMCVg
         yFRg==
X-Forwarded-Encrypted: i=1; AJvYcCXfET+A6akgaQFHFncBWaLZ20M1BjZBovIT3zpn8u0zzXJAmPJyJFRNZOpVIpm0xG3m1c4Idic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYIze+SPOfgBbmY5CcsFZCe+Q/A8PbNnk1lJbi2hFHO20+I2DL
	oYpWMpSY2Tu2b/ERzgh4XN76xDehKWA/7nC0o/ZOq9vu6ZZRr482CZ8tE0wFLXHl68UKbF7j04X
	rChXjswHYmcAkOAow39opAFm419HT0kKE6nEtMgjfI+Z9D2IHLo/3NfDxfA==
X-Gm-Gg: ATEYQzyhPhd10zqsPDeu4AwWQzGcs8f88ZiGRCE77rZ2LZv3Dg2yUy/kY7EDpY9X+Mn
	OcvAWSmvz1yuAyXdtwmRbZsQzMKqXZ6Zw3YqRkw7WdF54EEAeb4MXXGf3StJibYMAYEJEnVzQrh
	LYYDG3phRrn1O/Cm4T2DWNqamExtGzM2eqZNJKUvg3GVEQJcSuX+nzuKwzpzI01B4i35hYBUnB8
	PLTl8rCi4y6tVVrMtqIV722e83+qHYG4EoIFWw8KLE9Ao9wQ7vOBH64BL9BKgiPM0Y4Ivt65d+V
	Y4w+7eG/bYRYsBmLqNguhGUWTZziFs5jCVtzEqIHYlWOkwr37JrCO24hdHEhnBumGP+AorRav8S
	ftwAQAHKYZVxc3nYaYrSO5Z/KAqqV7bVN6RLc8MxXYy9stHQROBJF1AryfQ==
X-Received: by 2002:a05:600c:c0d5:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-48883597d5cmr86145605e9.15.1775120724265;
        Thu, 02 Apr 2026 02:05:24 -0700 (PDT)
X-Received: by 2002:a05:600c:c0d5:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-48883597d5cmr86145105e9.15.1775120723689;
        Thu, 02 Apr 2026 02:05:23 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48885553118sm39116485e9.14.2026.04.02.02.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 02:05:23 -0700 (PDT)
Message-ID: <0f9e9d4e-8083-4297-91d3-10d0f614c87c@redhat.com>
Date: Thu, 2 Apr 2026 11:05:21 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] net: caif: fix stack out-of-bounds write in
 cfctrl_link_setup()
To: Kangzheng Gu <xiaoguai0992@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, kees@kernel.org,
 thorsten.blum@linux.dev, arnd@arndb.de, sjur.brandeland@stericsson.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260329190350.19065-1-xiaoguai0992@gmail.com>
 <20260330065342.145549-1-xiaoguai0992@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260330065342.145549-1-xiaoguai0992@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232948-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,linux.dev,arndb.de,stericsson.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: ED5DE386886
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/30/26 8:53 AM, Kangzheng Gu wrote:
> diff --git a/net/caif/cfctrl.c b/net/caif/cfctrl.c
> index c6cc2bfed65d..373ab1dc67a7 100644
> --- a/net/caif/cfctrl.c
> +++ b/net/caif/cfctrl.c
> @@ -416,8 +416,16 @@ static int cfctrl_link_setup(struct cfctrl *cfctrl, struct cfpkt *pkt, u8 cmdrsp
>  		cp = (u8 *) linkparam.u.rfm.volume;
>  		for (tmp = cfpkt_extr_head_u8(pkt);
>  		     cfpkt_more(pkt) && tmp != '\0';
> -		     tmp = cfpkt_extr_head_u8(pkt))
> +		     tmp = cfpkt_extr_head_u8(pkt)) {
> +			if (cp >= (u8 *)linkparam.u.rfm.volume +
> +			    sizeof(linkparam.u.rfm.volume) - 1) {
> +				pr_warn("Request reject, volume name length exceeds %zu\n",
> +					sizeof(linkparam.u.rfm.volume));

It looks like this printk is remotely triggerable from each incoming
(malformed) packet. It should be rate-limited.

Thanks,

Paolo


