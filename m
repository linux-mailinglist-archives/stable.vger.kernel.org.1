Return-Path: <stable+bounces-212737-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIYlH6EDe2kyAgIAu9opvQ
	(envelope-from <stable+bounces-212737-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 07:52:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EE3AC564
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 07:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C6CA30177AD
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 06:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A42F3793B2;
	Thu, 29 Jan 2026 06:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n/eaifpH"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0527836EAB2
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 06:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769669533; cv=pass; b=HStGSOArP6sam9B//E0qald18XY8AbB3gl6pHO1/311Kw/ajAaOWZs5lvvgA9sNg2tbDEDoWYvzkTmY9iYXT4DAPTNiJ8NCShRIX3zp4jzdveSgXcEntE8gyxDsXBnYMhAbwq1Y//7yggRZ4yvlG66XJaZU15+iKJxO0TALJaCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769669533; c=relaxed/simple;
	bh=FjGtDgWO1SlY41VVnAbB43mPjgZbe16VgruOiURSZAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+FQPeBE0nOaiFEym9alPej9pmtEoClbtIIoYKWhbnxZNsqyebqh88XXf7Cg8phTzxZjXgfocm/qjRuvGKQeJFX8cI0EmihFNsuRSB/VEqBtVyvaKQbR45LP8mkynWym6KWI4f+wJLE6qBdtGnNjyk7k779xTcseAXQVhIMxZvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n/eaifpH; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59ddb20b720so2657e87.0
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 22:52:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769669530; cv=none;
        d=google.com; s=arc-20240605;
        b=aN8o76Ped21JLuaS6Bs3teHhLUFTMW/cwRdteX4th/tscJCPjVi57mXLNoY7SWpRm1
         qxi6XYPqcx7AdGJIVK+wyLMDcJzcbqHMCwDdBwvOSDLIP1QN4e66PEe8Nwobt7Kzu1BK
         +tw19W5WStzAxWlbYmY71Kjhaao/DQRgF/B/pQlggEqwDsMnwR/Mz2MFfJpEFjoH9V6D
         bwRfmoxMcEWwfPXPOGE4GnrPi9CH1cKkkJXU+GFgqyHL9WWRW1MnRDBh5Ve1lII9oY2O
         BKwcXVlGDe20XSyfgqQkcZCia8pPYaill24scisfSIvw91hVC9rqkCD1IFe5qv0Sp2XB
         o5/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FjGtDgWO1SlY41VVnAbB43mPjgZbe16VgruOiURSZAg=;
        fh=f3mZFE0/TaDOZ+cX6FPYsCK58KlcYp0YMDZOH8d7iA8=;
        b=BsKEZAT49e3QIUpDRzpTiqBJsovHa4pZjPatYQylCf6NFN7g3NW0LsG88xvPzdaeKi
         prYygX9WKGyO0IBD2L+/CaRit9VHhD8Z6GCg5TtTgs81hUmVHv5Rx19lnMEdfFrNin9m
         F05r92IWtMx8h94Wbp7GwQGiiwKWBRsNnQ92eAu2UUuEpXmVoibGIhSG7RfuWg5KgwEg
         NIUqtJb9IKv24DiCoPmp7JBi8ZrhZVx0P8MUP/QGw0NRPIUC8GbUcEwIVV+YcQEAr761
         6HdDKV26ffTVo82JAjfSaFpHSmwEyRSPyLOf+vQumtzerzJRbvw0mL2rdwWk/O40RqVz
         LFaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769669530; x=1770274330; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FjGtDgWO1SlY41VVnAbB43mPjgZbe16VgruOiURSZAg=;
        b=n/eaifpH1hrsPylm3Tska4BggpFBzzwsiGhKIAgQ8YcuYShz2EnXJUNjJrFkaFmvif
         PjyGqyCd589OnwZLyu8DXabizuQGB1dwiBQz0riwFhOSrXH8WK32e8jVVrqRT4lR09vG
         N58qqfh2oPZ/VdaNUFpoQnkgZJs2qRAj1FhXr66hWgAihjH2UXzPKVwKrZHznEnKoh0T
         Bwi2zPOWR4ZPm6FGzXP3RDTFghemNkkfQ8lNOKt1LHYhKmXXbFRImang6DsoVh7tnl6R
         jfuMA78RgqudQhVKATvWZC9CTD7EOBuVYO/tQhYjBYL3BaKdGajG3F+28Nn2XMYcXOrt
         5xUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769669530; x=1770274330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjGtDgWO1SlY41VVnAbB43mPjgZbe16VgruOiURSZAg=;
        b=VeJEasIPzC2IRbmdxWesxVKrbeFTdfysCNu+Nc5eGb7lF1EJX64NYSMQFuYFXY56iI
         +wnH3LiDDwzzEAHJNaoBx5GGZrosl3H+ukshw742Bq1fezqEGREqPk4kWyu1hf3kKqOV
         F7QCFGDX6SsoiXpvrWHhOXJ21RXGnWEMAQ0q4EimEYoaBxIitdMmpjdDg//qDPCP8yDz
         02Dsyx/kCr/MAiiilO8hNO8XRwEBKpHucnHSwiKjQkPnfF8PoviC5rtYqvW9tbnGZTAW
         dSDzDO7Kx6AdVeOuEFq/7k1yH7aD/yzCUw42RsNIYILm4IPQytB7A0Ag4bhoXMTWAGVw
         oG/A==
X-Forwarded-Encrypted: i=1; AJvYcCXqzWbzV3jl8/S2C7YX+wk4bexHdNeblhJxnnHm1YkZCToW+foI5ADxkgdAkRD8htsXepS3FRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmvwKHkcU58NVlgOcPcTcHxaGFr9oDsvO/BejrsgdfnvkIrfO4
	p30+/ogGUSfCxd1WPiAbrcKEYUfhRcoFkVId+1CIIQvuc4Cjf2/iiAbJXAJxfa4ymI6UAm4/WR3
	tG+R9k76x5boiEEX1Y+iOcDknQsS6f2W6tW3u91mT
X-Gm-Gg: AZuq6aJKwbxOci6M0zKCw1nmLZr/ZdTvW+NLhhd7CzMSyr7EgcLDOpbywH92Tq8apNA
	tFaIAcp9d+9AvSLZqcKtrWooGa2h4JDhanKslI0IjtcEXPbxRfqSQLC0SBi5vgWVPbcupqwAxPr
	7FsjpCWLQ7CZhS4vSn0WEXO0b6nWsnw6TavkqR5jKGTb1MgnDJefWMadDJ5doYqtcJqP56703PD
	ceRFSkfjKwLqubgXDbl6+HU/WqBzoXctJIQkd6TBO3Os83AoB3aBKqd9GJn7wTV28wfkSwuEU4r
	GhGpDNokG93HZw5M/TCCMvg=
X-Received: by 2002:ac2:4d0b:0:b0:59d:d71a:f138 with SMTP id
 2adb3069b0e04-59e0f53bca6mr56863e87.11.1769669529966; Wed, 28 Jan 2026
 22:52:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127012700.3311649-1-thomasyen@google.com> <4cb7b0c51d81f8e9959b0c50f12f1ca1416885a7.camel@mediatek.com>
In-Reply-To: <4cb7b0c51d81f8e9959b0c50f12f1ca1416885a7.camel@mediatek.com>
From: Thomas Yen <thomasyen@google.com>
Date: Thu, 29 Jan 2026 14:51:58 +0800
X-Gm-Features: AZwV_QhJVO37Zxsd9cxucU9IimOvnyqZH3k8tz47ECycTqX4QGae1MsU2bbRpK0
Message-ID: <CALw5pqHMhCKHWgqJMhGaXyMHoDbz5oxFkJvCRyC0rxvNsrmuBg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] scsi: ufs: core: Flush exception handling work
 when RPM level is zero
To: =?UTF-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= <peter.wang@mediatek.com>
Cc: "beanhuo@micron.com" <beanhuo@micron.com>, "avri.altman@wdc.com" <avri.altman@wdc.com>, 
	"quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "bvanassche@acm.org" <bvanassche@acm.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>, 
	"alim.akhtar@samsung.com" <alim.akhtar@samsung.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>, 
	"James.Bottomley@HansenPartnership.com" <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212737-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomasyen@google.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9EE3AC564
X-Rspamd-Action: no action

Hi Peter,

Thanks for the review.
Agreed, we should disable auto bkops before flushing the eeh worker.
I will include this change in v3.

Thomas

