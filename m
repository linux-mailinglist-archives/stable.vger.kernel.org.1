Return-Path: <stable+bounces-235442-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFaIEsbN12mrTAgAu9opvQ
	(envelope-from <stable+bounces-235442-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 18:03:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E38E03CD4C4
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 18:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 094533023E03
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 15:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1481E3321DC;
	Thu,  9 Apr 2026 15:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IEO6YDau"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6842228469F
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 15:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775750049; cv=none; b=e+fqPyOZgdLzniQGymqgNSxcMI4HnYqFxf88mMafGYdH8mSSyCiXF8/i0JJBw31IS4h/hyxLJnij+mpudNiGBBwyAHAtCV9NAGra5E4kJJu5pq2Bzgi+LJrzr7BAAtS+kMpoONT4AkYvaVI+3xdyf6pTn82TmmjWViBLWffzly0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775750049; c=relaxed/simple;
	bh=JaKWtpj7aYsMt3Ph+9iFB5XTzYl3apA/279VbkyHog0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQELmg9tZVH8Fub5mFCwXj3xlfuY+bpUESoF+qLxDa91+r7qYwZ1O7oUNk2ep0lppnsFNegbcEamKH+Uj9MU6exfNaVBaR5D3izZ/Y/LyZa+5DxdbO1Q3CWkgR2vzX0Aod1qjrlPoFVRmFCm5/7NG2yHXn9O/oqqruta5w++NF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IEO6YDau; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38df0a031daso1890551fa.2
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 08:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775750047; x=1776354847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3M56rBEz5OeVU8uz5WV+I+bOdPl8DKhX5/Z1vQpWSE=;
        b=IEO6YDauyyG+fj4W5uFBfB+k3DTXJXRrA2mmrPhzG/XGRGXiC8fzqr/tbkUs+ikzCo
         ACqtPil47uYkVxllLk6kwo/yK2dhY7eJNhQBYbgxfIAwfdh1faEPQRGrgrJBSmkTgjJx
         1KMaBOXGJSvqeP9vmBSMMwTKU16nzgm2KoWbo/eMMDxww7fd6Wg3eKABpQPVixUaMNge
         E+s4oc+5C2w5IhaoyHhtin/fAGV2aIhfH3UJ2Ts4D3osA3OIUpRSlJSynqTmD9xe9A9d
         RiFa4EemnqzeR24q0oO4Qvvzg6M22YChYoKFwi3GQdLYi79gm6MSheg1seERpN4eji2w
         RnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775750047; x=1776354847;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A3M56rBEz5OeVU8uz5WV+I+bOdPl8DKhX5/Z1vQpWSE=;
        b=qmko2QD9/ltMvXQNZMGMhXvz9iaqiDDHIR3EmkMLonYQD/lCNxPsQPDA+oQ4WeztBc
         UrmzHZq/FdXgYWQszQ5Ygej/k7B6Rg4VzZI9mRBH4TEFA8flSq6wzFYMQk1zCT5QFeAv
         MeOEOeYw0Sayjn+wH2vUbx0qKzLIXRuFEB3mhPAPA34OD9QSOcmErTOwPWFSoS9fQTMc
         hLi+oWnAz55ugbQJgFGuujAgnxZJStg5tyZfMZ8CaPXeDrQSDzR+EO4vHsaZu15Hx9H+
         BTj1UeTByDetjYKy0cYy3FrQ8jb4B3vKBeSKPWz+EdjM34RsRIwxsOpTGbLWIgdm3QHa
         asoA==
X-Forwarded-Encrypted: i=1; AJvYcCVxz8YBIT+eAGEB1kfGGnDETl4S9Rinkl0qJunCIz1BAgy4RF1NCBWPjMf0GR8sT7sHDABhoh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZzVKwYg+W5v1tDmindVDi8lX8O81Cl1R3/YRoB6UpARHppFeQ
	ZuyIWCAQIzwHUYJEGH/SKiOX7s5kel0aQV/OUwcvpiJwavVpFQZQ1uEoBlIW7ELcYPE=
X-Gm-Gg: AeBDievhWsdFvVwOuUwGH9rsBM/CbIVZmXuz1j0az5yMf64gz2iNU7P1ktCHrz5Iz/w
	5fr8vfshW+0zz9+3UZ5S9Sq9E//yjspah/6oUZs9AVzWsHyOWapcByxFbZx7fXA7YAvBPsZW5cE
	us5M2nn/8FAK1A2HhToK0LTuReIEWnXSVWbLetAUNGsRoXFNbvOXnlnDQFYbGILtC0xt4dqKzrw
	wbOim4KqdlxiLi+AJB8TMd7hLXYOxXuX6sG7yCfL0UnZKf7DBjcQXXASSbiOpOSEBbU6+zZLCBZ
	cTcBEiSOU+MajJY7v2endWfzrhdqQk1HboWWrRYpZQMcPCzGzxbdc8N9bOj18izJvoHgMhWGnKK
	Ppx02Tp425Fufw3YQfoXnijPbIZ8fqFJQ1Fy3+DoiQxBHPndaBV4+Hl2anTW0ABv0j4E79c5XV8
	1hmQFUct/fs2i1CcJErvnxdaVkZMolTbadWo8amUUD4Na4rWrfdYfxxq1E4Oc6C+I9baUdHuMRA
	MD5Iw==
X-Received: by 2002:a2e:be2b:0:b0:38a:325a:8a0b with SMTP id 38308e7fff4ca-38d91d47942mr33866011fa.5.1775750046530;
        Thu, 09 Apr 2026 08:54:06 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e495ae96fsm205631fa.39.2026.04.09.08.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 08:54:06 -0700 (PDT)
Message-ID: <9e4b94f8-7792-4310-bcde-b8a810d18e8c@linaro.org>
Date: Thu, 9 Apr 2026 18:54:03 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] media: qcom: camss: Fix RDI streaming for CSID
 GEN3
To: bod@kernel.org, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>,
 Gjorgji Rosikopulos <quic_grosikop@quicinc.com>,
 Milen Mitkov <quic_mmitkov@quicinc.com>,
 Depeng Shao <quic_depengs@quicinc.com>, Yongsheng Li <quic_yon@quicinc.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260407-camss-rdi-fix-v3-0-08f72d1f3442@kernel.org>
 <20260407-camss-rdi-fix-v3-4-08f72d1f3442@kernel.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260407-camss-rdi-fix-v3-4-08f72d1f3442@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235442-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linaro.org,oss.qualcomm.com,quicinc.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.zapolskiy@linaro.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,cisco];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:email,linaro.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E38E03CD4C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/7/26 13:34, bod@kernel.org wrote:
> From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> 
> Fix streaming from CSIDn RDI1 and RDI2 to VFEn RDI1 and RDI2. A pattern we
> have replicated throughout CAMSS where we use the VC number to populate
> both the VC fields and port fields of the CSID means that in practice only
> VC = 0 on CSIDn:RDI0 to VFEn:RDI0 works.
> 
> Fix that for CSID gen3 by separating VC and port. Fix to VC zero as a
> bugfix we will look to properly populate the VC field with follow on
> patches later.
> 
> Fixes: d96fe1808dcc ("media: qcom: camss: Add CSID 780 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir

