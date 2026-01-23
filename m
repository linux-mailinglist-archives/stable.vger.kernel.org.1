Return-Path: <stable+bounces-211385-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CYAHPCAc2nxwwAAu9opvQ
	(envelope-from <stable+bounces-211385-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 15:08:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F01EE76BD6
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 15:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C65123057716
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 14:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929F530DD36;
	Fri, 23 Jan 2026 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijXwU6Wj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99EF1D5ABA
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769177003; cv=none; b=cWK0f9Qrdkf764yRI1dDPNI2/CPyUIZANHvB9LpeYeaLAi73PBISsXsnlN+yGEyA0r/i+Aqkd846HKzSv+B1bY7S4lE/IIIH2oZG8XOIEk8lAs8rRbE6esyLgmy6vmlOUclxIm9/rwf+tNMOLHUp098eM/ZU41WC13C5OomwNV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769177003; c=relaxed/simple;
	bh=NQCeoHQjMPAF3JY+lHnBjng/gItcqZenN+9wm7CI+JE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBChwhY4GZujLMX7IawoRp+p+nrf5LhwWPBwgefK7lXfFMrNdZ/OHt2tpQtR1FLZXNCEX1l2vcD0FlHEdeBfT/efxTAnPdbB2pGD3HSdINisOAS1h1gEuHgDuqc/7rW+f//p5DxGeAKD3SuJgAVc9MOuNFpvHsH2suWbNxflq4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijXwU6Wj; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42fbc305552so2000593f8f.0
        for <stable@vger.kernel.org>; Fri, 23 Jan 2026 06:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769177000; x=1769781800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eflxrySSouHFZK8Z+UVBaTlYFEPw4EIIlMLqk/MN/DQ=;
        b=ijXwU6Wj3vgXyeX5oxdde0/37FPODtfL5HFL+xRrlFGjkNTdEZ2UOxsTksyH2ps176
         V/Vy6H8t378u7J3DFlWcAct/wTiAs/iBMulhpHeJnwaLz8d7T20/2T5Q+g5nrJBIYGuV
         g28TgPoHQEerIXn3LCxzPIh9RaCCRwUi2VD/IvLM4/1E8z80ZQr21kMtRfAFvSTXgIPI
         1ziDz++XzRQMbcSpCFQ/CG54Mf8uEys+w3mtcqde5XGv38trjknI0BbxmTMTqwMxVViT
         TUJCHY7PRD7AVj5nTWPAsj3SF+ds2GzW6AMz0IAdU18ZKE/husr5KUHC7CuvUuzoYgzz
         5Zlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769177000; x=1769781800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eflxrySSouHFZK8Z+UVBaTlYFEPw4EIIlMLqk/MN/DQ=;
        b=M/h5/GUEPyOFj4rGEsFj1lYwx42WJC9JPqDVegTRDe0yNFxPqNXx9r6KObm53N9v8k
         42FfuB21AYHNPWZXvCEsbF2LnIHV06ise9TPfLf0InCTQPZC9huFpVaxbBFpu3eEzRfw
         jzPWADUn/9emr5scJ8ddixCLiCbLNEGV5Tx+LGlsiikjRI8R1GAAyuaf5IQCL9RJWHz0
         LctS1XR3P1NsxyaFeNO5CXEyOPM2DeHZQA6V77Sar8HaTQgnLXXaK9hkSZW6u5QUHtrz
         aud1M3o9R7lG2gT0BNipDBSP3HdKloh9qm/so3J+a/LJBSRrbiWXx/e28rIUaLK5lZE9
         zHaw==
X-Forwarded-Encrypted: i=1; AJvYcCUcaFsJ6BUbAZ+7PmTmHgvESbebT/GPdtXV+o+zv/KOinFuUhcm/E9UVu4DftcwvWjGk4PKB6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP7T6n59gVkD7LFYCSrEO0UFJUMRgf2LMtOrKFsb60zvxNKx71
	cFTbubayl9WhzS3XSx6vmKsnZyictXg5UtJHPB19fdrupjTsWRdKb2MX
X-Gm-Gg: AZuq6aKAioxy6KkBXBRcdYceCXdvDc3uAHuyuKXvKgZAOfr3tFgzuUi5hcLmkTweKpa
	0v148A4vbusU5ML/389SDiDSWaSOlmIDnv/7zxrIBKEKM5yH3rXUAnX1ScsM/6BsnSFOLMVH4Jl
	nDcc9emJ8Z36sO6YzXd7Jq4zoDsIQ7H2VU79Xl1zh4WQ2WDeQaDa4D+HYr3suSTHzR1EIEK1Zoq
	Vm2cAuP8G4r+wn0nV9/3mqDrQaE0fc6ofbWVmv1tLOyKIMXyZWMM6OzPXBWAwvylj9oa9Km/cLC
	x9uPVtrjHR+PgTQogkKNAnr/3ILKaJfDuGo6ZhrmgixoR46Gh4g7mMPeDrWcHr9uZWqzQpGf8F9
	rgLz6Emd5/D8QEiYpvJE9ZgkzJT2cQZfeJ6dHGrZ3tsDwaQLHWxgJ+aamNeOCKNAn80+tte3yiZ
	1sXouyTpecJ+GVOi2v3gYYvhcZjIWNOdT3StB3m2rxhfDsA9fSYYkE
X-Received: by 2002:a05:600c:548d:b0:47e:e78a:c832 with SMTP id 5b1f17b1804b1-4804c9cf942mr48475245e9.37.1769176998771;
        Fri, 23 Jan 2026 06:03:18 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c24ac1sm6823141f8f.14.2026.01.23.06.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 06:03:18 -0800 (PST)
Date: Fri, 23 Jan 2026 14:03:17 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Leo Yan <leo.yan@arm.com>
Cc: James Clark <james.clark@linaro.org>, Thomas Voegtle <tv@lio96.de>,
 stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>, Greg KH
 <gregkh@linuxfoundation.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf arm_spe: Fix bitfield dependency failure
Message-ID: <20260123140317.4bd85cdb@pumpkin>
In-Reply-To: <20260123120847.GB40455@e132581.arm.com>
References: <20260123100218.233246-1-leo.yan@arm.com>
	<705c0889-ffb6-4758-941c-ccfdb367d9c8@linaro.org>
	<20260123120847.GB40455@e132581.arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211385-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email]
X-Rspamd-Queue-Id: F01EE76BD6
X-Rspamd-Action: no action

On Fri, 23 Jan 2026 12:08:47 +0000
Leo Yan <leo.yan@arm.com> wrote:

> On Fri, Jan 23, 2026 at 10:27:42AM +0000, James Clark wrote:
> 
> [...]
> 
> > > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> > > index adf4cde320aa..8d16619cd098 100644
> > > --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> > > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
> > > @@ -7,6 +7,7 @@
> > >   #ifndef INCLUDE__ARM_SPE_PKT_DECODER_H__
> > >   #define INCLUDE__ARM_SPE_PKT_DECODER_H__
> > > +#include <linux/kernel.h>
> > >   #include <linux/bitfield.h>  
> > 
> > This isn't the first time I've seen this issue. Isn't the real fix to
> > include kernel.h in bitfield.h if it depends on it?  
> 
> Good point!
> 
> bitfield.h is a common header so I did not change it.  I digged a bit
> and found diverage between kernel's bitfield.h and tool's bitfield.h.
> 
> 1) The kernel's bitfield.h includes asm/byteorder.h, and finally it
>    includes linux/byteorder/generic.h, cpu_to_le{16|32|64} are defined
>    in this file.
> 
> 2) The tool's bitfield.h will includes asm/byteorder.h, but this hooks
>    to the headers provided by the toolchain.  cpu_to_le{16|32|64} are
>    not C lib API, they are defined in tool's kernel.h.

Perhaps cpu_to_le16() and friends should be defined in the tools
asm/byteorder.h rather than its kernel.h.

	David

> 
>    As a result, we need to include kernel.h for perf build.
> 
> As you said, we can include kernel.h in bitfield.h, I will respin and
> send a new series.
> 
> > Usually you shouldn't
> > have to know what all the dependencies of a header are when you include it.
> > Or is there a reason it wasn't done that way in the first place? Maybe this
> > has been discussed before?  
> 
> This issue is for tools only, and only Arm modules in perf folder use
> this header, I don't expect this is widely spread issue.
> 
> Thanks,
> Leo
> 


