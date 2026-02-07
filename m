Return-Path: <stable+bounces-214762-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBoHLARIh2naVgQAu9opvQ
	(envelope-from <stable+bounces-214762-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 15:11:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BB1106209
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 15:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8287E3004681
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 14:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C65827CB04;
	Sat,  7 Feb 2026 14:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXZZWsbj"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D857B270ED7
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770473468; cv=pass; b=LHYXGOIWhFa30ILILyeTcLXjEOpGfeyr/L4TQtLjNmJYvFGqz42giGKlzeTgwsnvsFzt6AxjY6f2fKRG57Y4p+7gzY78F5ysCEQR0W2K29GVedJUGrs53B+sAiAm28om25epz1MPOyGSxAd8OBHK8zu1lY0GE9Brq3lvrQQ8kQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770473468; c=relaxed/simple;
	bh=ynCu+LQOF1MUOSRJYtAv/zUlhtEmIi/2yBlF5GbMk/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNzxXXfszlaMl4IK29tUkudXVXklks+2S521Rkn2icqnved8FEF0aSr9e7j7a2qU0nGF9ah5qeqJti98+hQsgYhJcjrn7dTCpQyuq00mnHlWEEdrjD6k0EnkNvPNWBy/2ZXGgOzY/JLXYK05rVKb61WZik/qDMoNTyQ9+pu8J1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXZZWsbj; arc=pass smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7cfd95f77a3so1117153a34.0
        for <stable@vger.kernel.org>; Sat, 07 Feb 2026 06:11:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770473467; cv=none;
        d=google.com; s=arc-20240605;
        b=WdtkvEHuWnGGqZDxDR9uvVQNJbVsyTh/kM8T2XOjyksDgGeA791GEvS/l2Yjrp53Hp
         Z73LR2wGnDaR05FSBF8nugAfzaYKZs8hN8xogKZEMLJoq5kZtGOqIBJqipr7BSMppdII
         8o9rqNwZQ2ni9JUxRGEAy0wRGF5RdKkA1+j4STAilgpGXhp2dm70YakBf2Iit02hIWd4
         kIgChBsscS2CCRd+DQvy7Fw4lIycfmx4BlDfrN3npkO3TfCLvShdzjuZT+VmxOTPHoYi
         xKPj2u/ikpQrvLfTXR0oj83CZ4tM4lnjIOrWerZxD0TiF4dkpZLrXJNozvqhdKh+X6zD
         sCEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ynCu+LQOF1MUOSRJYtAv/zUlhtEmIi/2yBlF5GbMk/E=;
        fh=Q3jTn47ryul+XVismKcWR3m9O8U9j3f6GhTaR4IRX00=;
        b=EQqpWa94MRmVF79Q+UP4Qkx1LsZNi/+l9z+pFHCIJrbLlnIICazifL/Nmgi26BKE7G
         cAq9dQk9k+8ySQb1wlo9VILaPlrSEY10YnWrht9uE/hvXvLl0hh64Fav2MGfMxvfQ975
         vwy4WKkpqCuX0ufQ0dySq1WwPG223Y/cxfeBMXlhfkQKQDX9LPBxHRfOYD16J8dIVpy4
         jItdnO13pOCuNXxJXnLqnJ0c+/PimC9KGKFwWVFEhnxeaqpyfkODbY2A1iIq2MdU0YFV
         yJX2I4ZqFKvou4KpXf3DHtbK66jQi/MwSs49/Q9SEqQQ2RPLoEq6Izr/hN13+dSoRhEX
         zing==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770473467; x=1771078267; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ynCu+LQOF1MUOSRJYtAv/zUlhtEmIi/2yBlF5GbMk/E=;
        b=HXZZWsbj16SxmGxJluLHif1QyEI+Kj0T0cSXxulZEgEKEVrSf72E59DVjMecna3sRC
         5HUnqcc4IMmaOZoRySn3o4CBi8Nsa6chmQMoio8WeyaJfFp2PXS57L47zgFqHeh1AXHp
         t7p6Yhh5wOomDLnvw6FI83ex0979JUfoJdp38u2m5ivQt6xb1P1l5VQgUbDLb/hrBHD5
         bWWS68Z//qrawnwL43NuR2dD5syuqtnzlcPOtDxw5MI27enOg4L5Z8op6He6Ks51hh+d
         MaoFeBL5yI+oTahjn8Cd3QHAgg8v2TBGg06BEf4md/8iL3L7GDMcxguZdroCNw0LLzLB
         Afug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770473467; x=1771078267;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynCu+LQOF1MUOSRJYtAv/zUlhtEmIi/2yBlF5GbMk/E=;
        b=hgo+0oDqhs4KvkP17/yfXzJCBW7uvUtGJLpThQ1Z8SfCXdwW3PcorlLrWQ35z0Wfya
         N5r0RLw+sipvgm77JGyhau7iwM4da9bwi86AYY5mE70y5ashFmAkF0dZTnqXiRFAs/W0
         vA2Y1Ko3bYJJzQ0Xu2c5xN1fn+Y3aq2GC2rUFWWtz/4DHfwMc1GANCIlYiYMANfX/A5d
         ncHD7mc+OP8GXYFso3QTZX2dTcAAxF6L9GkpJpW+YeEpP1WJWgMcESmX/lPr07YoIi9q
         K9cIASx6XuvHxA7AXOmhOPBYf2aXefhlcvdwmb3GX5DoaY3H+N5uTgimS7rmpHCTq8Qb
         jVxw==
X-Forwarded-Encrypted: i=1; AJvYcCUpO90fhBdnfToQRQff55SaRL1KRuyW+U4/nFlPxzK0zhI68vfRtEymUpQZBIHR+SQNjwWq4MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx39uYuhyA5wN5fmdQhOk5NTEXRHjyrEh5Lps9cbm3zaUzHhhJr
	cSRo6EwNA9HUqwrSMXGjfLrGf6yN/2KFgmBW6SyDI6PDwrdLA5zzZ4B1CTmTVzFqDqWdc2Mw3uq
	vcZ89jSyTf5aT/7v+DfB+3Wrm0anjSDc=
X-Gm-Gg: AZuq6aLAyNocYrec4bEonC2RRi9QAucQUfsDXRoqWXuAf/PeaUHKMs9czBvXpGxP1Ej
	Ae6+GJWZDAN4SdSaawvKmrarQ5gPZ+i5Q9DB2mzkz0npPN7JevJVM0r2SeFWbaZW/rjHwFODZl1
	ozKu76WbFT6lotRskzUTyhLdJ1ZweazIob+Q7hjkagDNvCS6Gw2kpeyxWnJwbRMkVOo8Uc590gF
	suhDmFvIXBf/i1/U8Drgl41CU4V7Ext/F+maSoKZVYLnjPAc8kR1MAak9n3dUkSxhU3+F3Nk0Cf
	ROSaH9UC42Vjomwb4trMsxf8tumFjiq52HkWGxb1PirgJUSpxi6tuL3onnM8
X-Received: by 2002:a05:6830:83a2:b0:7c9:5bef:e9b with SMTP id
 46e09a7af769-7d4643e5575mr3562820a34.3.1770473466626; Sat, 07 Feb 2026
 06:11:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120121105.8959-1-hanguidong02@gmail.com>
In-Reply-To: <20260120121105.8959-1-hanguidong02@gmail.com>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Sat, 7 Feb 2026 22:10:55 +0800
X-Gm-Features: AZwV_QgHv_bKbssi1BqytOrVelCG7ayxL_FlI4KKAvI-JSERB7Ri_i0u3T01qi0
Message-ID: <CALbr=Lb1wp37PH8XyPOUMts-x0Spr04k9HZjbCP8Li1-y9J0Uw@mail.gmail.com>
Subject: Re: [PATCH v2] media: dvb_demux: fix potential TOCTOU race conditions
To: mchehab@kernel.org, mchehab+huawei@kernel.org
Cc: hverkuil+cisco@kernel.org, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-214762-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hanguidong02@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable,huawei,cisco];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C4BB1106209
X-Rspamd-Action: no action

Hi Mauro,

This is a gentle ping regarding the patch submitted on Jan 20.

I would appreciate it if you could take a look when you have a moment.
Please let me know if there are any questions or if any further
changes are needed.

Thanks.

