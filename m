Return-Path: <stable+bounces-233716-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLjoItBi1Wm05gcAu9opvQ
	(envelope-from <stable+bounces-233716-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 22:02:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BBF3B42FC
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 22:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25B5B3025792
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 20:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405423793C8;
	Tue,  7 Apr 2026 20:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F874Wtgb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqWx5VeI"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C5336EA8D
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592130; cv=none; b=i9GDsbzN4w5AmbdkNA6M+rpi+OmTvg/NLsT5YwTPjJWCPb/A8O8vTHQXkmXdzX4QVmNR2HQx434+CbLTVpLCgFkAAr5jDx6d/e6d3P6nTiLvZCkrcKMuCwU84VnuTDc23AU6dZ0UbI9p9belNP8i0jXMxi9yycNp+4eDERcAXSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592130; c=relaxed/simple;
	bh=hJtN8K1NO+1GlGmjmYQ1CDezEvY+K0yC5MUDZO/1Nm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYzpAmXfHADo8HkrROBHvYz7v33yQLELZmVpO1U6M7ovd8f4Q95aAzhMRicfncawYMPkWd4t7BYpe/p8o3J60wHYqZZlguyU1g7Zazs8BrAFCxm3M3tD9o7EYkUsG3ThghW1bVGVgm6VYwf9SP6k2GT9DPuA3Fbg7q8q1wtJSM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F874Wtgb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FqWx5VeI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775592127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nwpk7x3/OYthLLbkTiH6r3E3G4VZBvtoK/r2DsOIAbs=;
	b=F874WtgbBPF7F1AEBKjxSHcuRnRoAGz1HpQBBrTe60Omy5e0m33bm9bXXs3EokqmlGZGx9
	Fyy2KNSBbEauZCkRfgu75TeEMTDJI9DlsdUNVw837bBYJZPG/b3XwpVyEGxgEaMGW6mrRj
	sXnNhHouwIc8ZLXvp3g5Ly1sUk2N1i4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-PxeJk2yyNkyWGcY17MqQAA-1; Tue, 07 Apr 2026 16:02:05 -0400
X-MC-Unique: PxeJk2yyNkyWGcY17MqQAA-1
X-Mimecast-MFC-AGG-ID: PxeJk2yyNkyWGcY17MqQAA_1775592125
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50d58bed44aso170254391cf.3
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 13:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775592125; x=1776196925; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nwpk7x3/OYthLLbkTiH6r3E3G4VZBvtoK/r2DsOIAbs=;
        b=FqWx5VeIOfWSE4/QZPtqixPyXmZl9IrlsvnRZ//NWBlMIXudBruVWDjKNnhSokOEdK
         +EdW+rCv2s5wFVVgeWnp169ci6NoZTPnwRptjRR3yrLm6v88iPCZk8ofdlfPJFdTU07F
         6CD95+uOmTziiZsm57uj0+JdcD/VgTI1JYA7EOv5DWe/Wsb5QTdOfl7DmQe0nkTHT+nA
         ibDLeu6uriUa3ANx+VrRuB5ET91gwoPj+u/wKqjPwMQmYz/ilCxG33eAuARwQshXzhez
         oYaarivonjgfYRVuk+0uXvpK6NNeIGN0ptwnFDbZMaSMex2Uq+hvsVIjCS1lmbTfYP0x
         LKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592125; x=1776196925;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nwpk7x3/OYthLLbkTiH6r3E3G4VZBvtoK/r2DsOIAbs=;
        b=kXEEODDfi54S5pLAK2o3vpnx587XfG93eeuCWXFfc0awf8lM1x+EBIOZ9MMZq1G4x+
         sxs1eGMfoorQUOq98/AFdRomdHwBYu6dvJHByaN4zz9dHIIB6Fzdocz/o+jRFFRHr0S+
         cWksEVrpyD29FOAT6m8KSO1pcHQZSGqn2h9rNwlXy3mJ3rOcs3v3iONsD2RwPDtbauGh
         I69tYKrAJSGfMn+aFB0Jy5h65qvI1Zh735RW8PIxUJO9/dPsMsiBxrYQJwOuaXd/a93D
         iPEeW6CWUu9kJttvyIB64QPLWgTNgO/lwBX6DjT7nlRiHd8aT9U9K/MANkAeNTu9ki+X
         Zz6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlcQgo/r65FVIKOFqQOXU7B0IWljS5kMmMvemaAR9NIU/n/cR5G/tkKiGyCvI6PTNRvOeV2FA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDpy+N2OFLMfZi+PFD6cTG0HbYM46KyTEUxBkzDgtvgvhtVftK
	jBXXklASPDZ1U/MzObVb/L0KHzN/eJEAdl1YXVe6EymvPEVToojA05F2Z93xqXwjNBFn6x1Wecn
	xERpY28jri1wqM8LdkdNIH4/E6bMAYoK38v5K6Tu9lXTcOdXbAnbi9lG7Ng==
X-Gm-Gg: AeBDieuGeujN35zRNJyiwkFHenQ0/drqruwFLmm6Z473ekymcMV85RrYBRE9Stybibc
	Xh69WgxEAsL1s7wkL7y6TFGwG5en5bKt6O0BZVS2uT5rKI2mi0usstrNs3vxgIOi2mqC+ByU4ye
	3DFyP2BrO37rDkKRFrP6yjKYXqPjClVm8whS+sXHv2FV2QSHurLjfdCBZMVkr4WfasTpqz68dWH
	1yGaeVteArmzG+RT8N3rVfiQTb3Si+nPzUNPMzHsh9g4inQZKXYRO8/gjUwBWJ5YDWNOHoALFBS
	VF3RJtSzfQHw/pKM43w7P+zf8EINVgu7lmNmScCI+h3mYUlqp9JSdomuzwR717f2naN6UEKExkm
	qV9/ED7Z80tZpHQJ1dc4=
X-Received: by 2002:ac8:7d16:0:b0:50d:66b6:1564 with SMTP id d75a77b69052e-50d66b61c27mr270620031cf.14.1775592125155;
        Tue, 07 Apr 2026 13:02:05 -0700 (PDT)
X-Received: by 2002:ac8:7d16:0:b0:50d:66b6:1564 with SMTP id d75a77b69052e-50d66b61c27mr270619401cf.14.1775592124495;
        Tue, 07 Apr 2026 13:02:04 -0700 (PDT)
Received: from redhat.com ([2600:382:772d:3619:ed0:4a9c:acd6:3fc9])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4b32b59csm177586281cf.13.2026.04.07.13.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:03 -0700 (PDT)
Date: Tue, 7 Apr 2026 16:02:01 -0400
From: Brian Masney <bmasney@redhat.com>
To: Johan Hovold <johan@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH] clk: rk808: fix OF node reference imbalance
Message-ID: <adViubS3B7BfRlWB@redhat.com>
References: <20260407095027.2625516-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407095027.2625516-1-johan@kernel.org>
User-Agent: Mutt/2.3.0 (2026-01-25)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233716-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmasney@redhat.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,collabora.com:email]
X-Rspamd-Queue-Id: 57BBF3B42FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 11:50:27AM +0200, Johan Hovold wrote:
> The driver reuses the OF node of the parent multi-function device but
> fails to take another reference to balance the one dropped by the
> platform bus code when unbinding the MFD and deregistering the child
> devices.
> 
> Fix this by using the intended helper for reusing OF nodes.
> 
> Fixes: 2dc51ca822e4 ("clk: RK808: Reduce 'struct rk808' usage")
> Cc: stable@vger.kernel.org	# 6.5
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Brian Masney <bmasney@redhat.com>


