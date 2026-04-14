Return-Path: <stable+bounces-237751-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJUKNX713WlolgkAu9opvQ
	(envelope-from <stable+bounces-237751-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:06:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 461D23F6EFD
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EFD03045EC1
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 08:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68428386569;
	Tue, 14 Apr 2026 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mo6Qnnmj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxhfafsM"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E1138C2B9
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776153761; cv=none; b=fD6JWGQFrr+GZb/rE297AIdRkJoVIZwZgdEizfyB6peHnkM2PXe2DR6oJRBKKt+P0gGnDEanjF9IYvcjvnAlyDDeiTmTuq0XDLWhnU2OkMng/Ps5LrnLxiBFB+Z56AFezA52NqlJ0Gyhchw38rRfus2Wi8f7oPv+vQ12t6bffmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776153761; c=relaxed/simple;
	bh=rZCA+zaQ6M5iJd2rjJRrrZnbpAOEaBFdMeSHQoNeGw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2E/EjOhnbG6E+Lh19x5Dt3PTDQ8mjdzatut+FRnWec7mtTHLXPsSNc0vzXcjFjJxkh/lYnDK5rm+iN1ITzWvgo3x10NIWBLoJNdYJsrBu1iNvr7M2pq7KC+KAW41NratAB41CZPzfAfmT54Tlauz0To04raZ6Ijb42Cl0CLNZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mo6Qnnmj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AxhfafsM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776153756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I0Zfw5O+OpGTZWtCSJAetrjJ/SPWXO2K80aEA+W4QDQ=;
	b=Mo6Qnnmj6w/rXlQNeIaVryTktns69qPBIhEsncTOTTjt/9SiuchO2ztOMoUIut3cvDO00y
	Mk+wD7AaWUAVjr+ZjCQ92cAdoCIv95lOnXiSV4mZNfgCSbTCZuEe/FkdNzl0G0OG9yK+nx
	+kXPFmUA2H14SxeysxCOAPKq+DysKJE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-Mfgtgt24NqKRYDReFnJZcQ-1; Tue, 14 Apr 2026 04:02:34 -0400
X-MC-Unique: Mfgtgt24NqKRYDReFnJZcQ-1
X-Mimecast-MFC-AGG-ID: Mfgtgt24NqKRYDReFnJZcQ_1776153753
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488d56f87e8so30196825e9.0
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 01:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776153753; x=1776758553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I0Zfw5O+OpGTZWtCSJAetrjJ/SPWXO2K80aEA+W4QDQ=;
        b=AxhfafsMAStSb86IBz+cNdS691lyJAKAbbSwPqslo6t9NUvsZ8uVF+LSg7n41OddFW
         A4JuigsgsyjhDU+mInmvOn3+DB36Ex4QAJjhPKLmbK1+no8xrW08WB0MpkuBJESzowjj
         hJqE1pcRoC98NI+iAIR/BjHLvaKTLBi2L8jMhusQCZakHIt3yJnDV+WEmAM2Hq4asxFD
         dnwydnNLlwcFXF+psR0DIDMaVwXkfeOOXOCnEVWC3vu6kC7eH9bvJ5xNIwsUg/laZWi7
         993feDyz6Q55gW576VqgnEqGhxhlvSPD89FzELqMX06oEV/30xvQ97Zv+seAVrT/+8Z0
         7dvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776153753; x=1776758553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0Zfw5O+OpGTZWtCSJAetrjJ/SPWXO2K80aEA+W4QDQ=;
        b=A8zhnsTb3LvgkwAFcAgm2ni7YHJPll17WUI3WwYCmwhp2eXiebzq5tMGz/2TybjJGI
         VoAgdB8Oxi3KJOySJtlhH/KQ/UcUlMCi3e1/Fm5rufHzwD2hwlBKaeMSZcyyEHkboSB1
         ya5BYBMSLfMrnrIejVTcNV12TEc94bGGp8jtpFUtqU8ecGbei/5xLQpwfeD/CibwGh8b
         Yk6cj5EkRj3LigpqgSFh4D1UczQ/PJ00RwYddhir9mFyWyO6Z0TUKsu+w8UC1Ua5K/wV
         y9kljcw64I2bZNdMJTBPQjiQoTBWWtZOGUVPEur+oK7RGg0EwtjNtP07LU2b1olb9Q5e
         rySQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xlbBcC7vYhjWq45PxThkVncVJgEsR1rTbNeyC3DMWWJXtamn4rHU5ULdKQ2HIf4+wxMcXFng=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS9TEHN6BLjGxD6+9LQVKM/iqHCkNUq3l21QjGOzEgD1Lbv9Wv
	3WFWeF6HKF1rwj54kY/hNApJJ8WZ2o/6X4ZfcUh1+JX/OP6GigOq9mY/rid18rtZvSsgns5rDhL
	ddjSHRwPmxl1bKDJ9Xw1qYYyPDY2vUL4tNc294ju28QCBowhvsKFN3HCdng==
X-Gm-Gg: AeBDievM/6W9X5WzIyFfmvesX87LoFCIBQGeIJsaXOC6B0uLykGS2kwgfv86spZez9n
	VdKKe+ibDJE3YuFbVvjT2sj0Yv9b795rIqo0vlRiOFtuGjivgANkpzderSvzEKJ0nYOIljzjD+g
	DNCc42Blj/0larzUc/GEfoyFo0inPr4NGBzzWp4mlfEcrQCGp8gKbKJbZW/FRpt/huVmx2hlEA3
	GKWRFADJ8gohigQi01YluBJ7QGnK+4dau1ScR73S6pSUTlHsWitXbH9Kr7uTOX92j1uFBL0at4e
	nCBknOPWtpZdsBOPLztnNhHVqbB7Gmdj99fEvaDViXRP9Pgi2aOpxO0/8PdLwWcV2T4tSFVWiAR
	0P9wWjXiHx02PE+7ppyKoolBf6IkmARujv1EUGf6NuZvhDabs3Sup7dtk
X-Received: by 2002:a05:600c:681:b0:488:e192:6fbd with SMTP id 5b1f17b1804b1-488e192710cmr86691385e9.30.1776153753362;
        Tue, 14 Apr 2026 01:02:33 -0700 (PDT)
X-Received: by 2002:a05:600c:681:b0:488:e192:6fbd with SMTP id 5b1f17b1804b1-488e192710cmr86690905e9.30.1776153752818;
        Tue, 14 Apr 2026 01:02:32 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e4f16bsm37458714f8f.26.2026.04.14.01.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 01:02:32 -0700 (PDT)
Message-ID: <67d12c45-6c9d-486f-b3f9-7fc50ccc9a5a@redhat.com>
Date: Tue, 14 Apr 2026 10:02:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/3] nfc: llcp: fix TLV parsing OOB and length
 underflow in nfc_llcp_recv_snl
To: =?UTF-8?B?TGVrw6sgSGFww6dpdQ==?= <snowwlake@icloud.com>,
 netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-nfc@lists.01.org, stable@vger.kernel.org, horms@kernel.org,
 =?UTF-8?B?TGVrw6sgSGFww6dpdQ==?= <framemain@outlook.com>
References: <20260409164129.GO469338@kernel.org>
 <20260409185958.1821242-1-snowwlake@icloud.com>
 <20260409185958.1821242-4-snowwlake@icloud.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260409185958.1821242-4-snowwlake@icloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,lists.01.org,vger.kernel.org,outlook.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-237751-lists,stable=lfdr.de];
	RBL_SEM_FAIL(0.00)[172.234.253.10:server fail];
	FREEMAIL_TO(0.00)[icloud.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 461D23F6EFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/9/26 8:59 PM, Lekë Hapçiu wrote:
> @@ -1300,11 +1305,17 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
>  	sdres_tlvs_len = 0;
>  
>  	while (offset < tlv_len) {
> +		if (tlv_len - offset < 2)
> +			break;
>  		type = tlv[0];
>  		length = tlv[1];
> +		if (tlv_len - offset - 2 < length)
> +			break;
>  
>  		switch (type) {
>  		case LLCP_TLV_SDREQ:
> +			if (length < 1)
> +				break;
>  			tid = tlv[2];
>  			service_name = (char *) &tlv[3];

Sashiko noted that you are validating a single additional byte, but the
code reads 2 of them.

/P


