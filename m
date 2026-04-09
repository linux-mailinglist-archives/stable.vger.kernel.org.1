Return-Path: <stable+bounces-235439-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBRiJqfN12mrTAgAu9opvQ
	(envelope-from <stable+bounces-235439-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 18:02:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E75313CD496
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 18:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B3203045235
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 15:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFF0345CCA;
	Thu,  9 Apr 2026 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p1ILTGxc"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DF731327A
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 15:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775750000; cv=none; b=CkVj7veO+LaqaxhFvPp1UXvvmyt+ncF9HBF5QUAd1ftLDPR5+VqxxavVqYQU/ONc06Hh18kvcMjQq1Jrg3Zb4hiWD7HudA50JRJTWgrOHMfdT4Y2qcQj1WeBWvsfL7PxjxTLYppT+rPQaNqkp2zEEWrWgzJxbASdnYE5j161StY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775750000; c=relaxed/simple;
	bh=CcfeUTBqdrPWX9PLWNaqEnioi2DbZM/+yoVkROngFHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OFi4alqfhJGFlc/pyxXJfC3xAp33vUSIj91zB6yqHs8Xp4oDBkL9Bd9/V/S8lXCzJhF6kQuzIRwTCVWcflWqhaPJFegK3ZZt/6ckUKVV7luya2HX3HcFGsCXNJob4hI+VGKYLtIAzIFK6fVw15X3yXqmxltE9PUrpXZ5e5Mrf6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p1ILTGxc; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38e203fbe14so753051fa.0
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 08:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775749998; x=1776354798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dePcqvygy03K7J//IlqvJIbf/FJzL8WZk9xUAjuc8o=;
        b=p1ILTGxchXHgH8PufWY13xJvOeG6AEee3Hyla1EuSPb0chDVpiY7yMtzth3G0zASU1
         d+NwNqx40G5eWz6uf49gau2wZqzrAl6aeTTcCv4ZCqWunL2hCb1rjPEpasTFoZ2u7Mjj
         9qLlpWP/Xron5nn/RsgCkm+0Ze6nvYvnhZYvIDC/erW3eNmmfFrzP6/unawA63uImEEO
         2b3tbjoCpUlKRngVYS2+/DA1o7CvXmsQ9bPlE9HbTzMLn4rttz8GEqqLvws8F333Dos1
         3zfpX029enhSWrRPaWjdLqXeypuAClQw3R59xahNjb09SeB2K7zzKJed/GC2x8FC39sX
         tTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775749998; x=1776354798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2dePcqvygy03K7J//IlqvJIbf/FJzL8WZk9xUAjuc8o=;
        b=iwdLeaU80Cbp9xiQQ+epzDPMAlAXqzSn4+dhKdrIQtgn7dIpeUbHSG8ZzoWNYxWgbI
         SAzaUp3+8aiKlpWC5D5jhOpwL+acg3/WqF3gHaMCnpcnR2LcHzwEV4TQeHscV1zjyxgv
         /CXpvoRgk3FfCaRAAb3QOpZuoDc+paqu0tP07+fMAZlOV+PqlHSBBFMkyu/d7/GO9v+l
         q5s+xqm3tRPCBWdLjDim5bq5mC5JySKVQQrqOE2Cp7m91P8vZKy0v+DgSg8GLxbK0Qo1
         d6gttNPkG5yImKTnPWA+lgI6WlNjPW+5Mr2e6t/jMER007tNaxzEx06zPKZBSp1dQQu3
         mB9A==
X-Forwarded-Encrypted: i=1; AJvYcCUTC+2csMKx1bemFkV3OZE/akeDF5z1ciYa2JOYBxICFk45+VLcMsMgc6eBsI4lFYOH7juTGSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA1I/ujHe8jXsMFJZSrqwLK0THmEqN/fBGomkhEZmhZsvQiuZI
	cGY1xD9V9rEGwXCfKOkLNFnPdIW4Idkk1GotfRNgcegB46GiLCjyA1GSQIQ6p3pPKQY=
X-Gm-Gg: AeBDiesBy8yyultJSMJQeZ+ReBMRYLKRay+z6I3ns3IyAHN8Z27ShTE2WAsXwTe64ec
	UtN97s07/WZ8vt63XSR5Q6HJzhtCA6DfbPQSBzHjnTQ6QlQ5mqKf6JtQJ1jc1UK09Zdsa+mprsy
	x+iYmB2kD7UQVnEdyfxIrlbX91uOOeSzmr0ooXwY08g5AxdEm6jxg6DD/2ex2Om4VzcRbhqnvsV
	t1dDuKJdhIe2jBdGvCtUy2VFWrpeJFQvbCMcNxsj+MkILD2W+sMwOMO9ajBPJCrWWMcXk/3fdJH
	T1FWJXMGQIXzWXRAD49Mzz1LKejGt03ue1M9Y2Gg2x2bW4BrNKJgygfWatxvIvLJi4Ak1bflyEh
	N8syfXeDx6vGpaCiC06VZ6PO58P64A4fPDttrGtjvuHM5GafvPJsHd3fQW0VbWFIfV+uhRX+Xbc
	tzAi+pFrcv1ZPmVap2I/xnS67jLVnKn7H8fl/u8CJB7JoRjJ4AOWlGj9br8MYRrZLQfZKpdRdZf
	yy6vQ==
X-Received: by 2002:a2e:a813:0:b0:38c:6616:e2b3 with SMTP id 38308e7fff4ca-38d9d4e188emr35046621fa.7.1775749997451;
        Thu, 09 Apr 2026 08:53:17 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e4957eb57sm210041fa.36.2026.04.09.08.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 08:53:17 -0700 (PDT)
Message-ID: <d3c22f40-28af-4ba5-90e4-61643ad6d82f@linaro.org>
Date: Thu, 9 Apr 2026 18:53:16 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] media: qcom: camss: Fix RDI streaming for CSID 340
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
 <20260407-camss-rdi-fix-v3-2-08f72d1f3442@kernel.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260407-camss-rdi-fix-v3-2-08f72d1f3442@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235439-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linaro.org,oss.qualcomm.com,quicinc.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[vladimir.zapolskiy@linaro.org,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,cisco];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:dkim,linaro.org:email,linaro.org:mid]
X-Rspamd-Queue-Id: E75313CD496
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
> Fix that for CSID 340 by separating VC and port. Fix to VC zero as a bugfix
> we will look to properly populate the VC field with follow on patches
> later.
> 
> Fixes: f0fc808a466a ("media: qcom: camss: Add CSID 340 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir

