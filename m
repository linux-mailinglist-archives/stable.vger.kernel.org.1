Return-Path: <stable+bounces-212946-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIedNNUmfmmLWAIAu9opvQ
	(envelope-from <stable+bounces-212946-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 16:59:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E264C2D5F
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 16:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 26D2F300615F
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 15:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F6833EB17;
	Sat, 31 Jan 2026 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="jAyWIZvV"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA9D33DEEC
	for <stable@vger.kernel.org>; Sat, 31 Jan 2026 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769875138; cv=none; b=c3lox9o1/uvulNeTLzIsBuwetWeHbGpBKhRYYBuCBWe5ChmMqSVCh1Fv6jDhu8nVMc8y920Bg6QEwTQ5m/sCqKWK8KYoSTZ9Qo9xQv2U9vEq7CxxSOaQt85yHc5uECB46IE3dJdAfsRQxAcTFUtvWCBITGV+QNp01Kp3MF1eD6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769875138; c=relaxed/simple;
	bh=K9aN7OjuKemtuSTajY0LoUlFdOIQZsAHYT3xi+Lw8SQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dvexODhncf9Y1+Klatldw4djKz6Nt5Yp0QK5Bvv2rL8CHVL0EfrsC3NIy1fK8Mr1+ywNGo+OJnc3Yp4yuzO6t2q4F56yUHFIg3plMIRlpiQU2mrm06D782xhd2oPVyr1mlywdEXdIdtx/JbfbroxWvWSGZ7Ry2ZLJRiX/breQ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=jAyWIZvV; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso2355361f8f.2
        for <stable@vger.kernel.org>; Sat, 31 Jan 2026 07:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769875135; x=1770479935; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FVER5vPZC6mrgsjqcbK85uhUXRqOLGCzOU5rUyInYAc=;
        b=jAyWIZvVzZOL7FBF1Z2dsEP7T97EjKtDKtxreN9rC7hcjhrUkcrw6bN33SnHUCW8Gk
         A0+LaSaix/+/GD3q2d31Vl8aNa89pOuOTAFXEHxHMx0IBI+Uc6gyrt9GivmTs4/OeIj8
         VZU9vxW/BMWaLT8cvko+NTOISfITbvC9ohtjXsf7TgQBwq+kdhuKutBGwDs0JwkuqREA
         yC2aNgxP2FFeVdDsvIHh2qck4yNmVG0tPHibmLHrKBX++EOcpQ9ERj93DuOxtxAly8eB
         7KXVO46y9jOmfoTlhlr5QAFY6iCECHnC9w9fbKcGpnvBjlxZ3sgNxnAiQlNjcLjB8mAL
         ZeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769875135; x=1770479935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVER5vPZC6mrgsjqcbK85uhUXRqOLGCzOU5rUyInYAc=;
        b=oQAqS8A+tGUjZCuY4qfncVfXdw1Rm75dVaFif3aTJUIvF95badK9UX91ExZwy4GSAf
         DMa9j/3ZYyXyPjyMj7hY5/7Gn/c5SjVECvT/Rpe/+sPwv6NQ0zYw8xEnQZdIH1/OTvrI
         Qe01ayohC+JO5cMa7meW/fqg/PeLveGuNCJrs0HdmqohO6JkkrleJzLk15J9MxLx7UU4
         9N/PZpN3Aksk7L0PQKhXcMPOhJNEhRl+mDPsVXuNdXEEY000R3836qj6KbBtJ2++r7jv
         EO6zeGIXaTowjgmHVyStDW8e4WG0M0x2/coesaQPQhut9uVtZZcv51EUJVH2TBIPacBD
         29Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXFSrztJCSq85QstxOlcnxxxbjK2KGgppqk9+8af9yExtC/9HjzByhuBlgS6dsvRoVdzoIrz4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ20wWiXHhcMeD1vzgH1+35mSuusF8vjZ2TRauDyoinSELKR9q
	UtXXAWSR2HTyVOs0yqeoomB6zF5qAmrafrqlwYON71lkb+Xhva27zjJQ8Rn1QemjVDk=
X-Gm-Gg: AZuq6aLjklmSI24NXa263Rv/VXf6jDy0TrHhiP/lWirSK/rg+JfSPkhORzHZCGJFE0x
	HODIoiweweVeX8X5F3TY0bwuIHzUHjepiBRJicGJlpt21MAR9z8hXRNFe5UXCuSBHhmj8r3IVpA
	a63jjv16NbeNTvIoNh+mxLT4EyCXJ2xfQRIF39GN9G40SWnO0q1l/2T6RgTaZCPDt/PYk7h8eP4
	wZZsjUjZFu4DRQEVLx5QG1qvA1T1fnxtjBCFbvOuvRmYw92M6CX1ZUn66sRLQBcwmS4ifMYr6mj
	/qlf0WrRV3vEQ73GbQaWWz+peRUgZPBWt/vJh5EMdgLLlQALX/BnR5on4AEgZo8IXNXhf0EQvHz
	nNC7+pwc14GH0UlruVe3w7Yyj1WjmCuPYq6l+ZR3ydbdbBrH+xUNlSrmHWeXEiRe2zCxRYaEBfH
	F7nzpZiJIhXkfj90N6CQ==
X-Received: by 2002:a05:6000:24c1:b0:435:8ad8:b7a with SMTP id ffacd0b85a97d-435f3aaf763mr9878839f8f.46.1769875134874;
        Sat, 31 Jan 2026 07:58:54 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1322f40sm29757534f8f.34.2026.01.31.07.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 07:58:54 -0800 (PST)
Message-ID: <a34bbde5-1dc8-4cad-8deb-f2e7855eb4f8@tuxon.dev>
Date: Sat, 31 Jan 2026 17:58:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/19] nvmem: microchip-otpc: Avoid reading a
 write-only register
To: Alexander Dahl <ada@thorsis.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Ryan Wanner <ryan.wanner@microchip.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 stable@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20260120143759.904013-1-ada@thorsis.com>
 <20260120154502.1280938-1-ada@thorsis.com>
 <20260120154502.1280938-4-ada@thorsis.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260120154502.1280938-4-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	TAGGED_FROM(0.00)[bounces-212946-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,thorsis.com:email,tuxon.dev:email,tuxon.dev:dkim,tuxon.dev:mid]
X-Rspamd-Queue-Id: 7E264C2D5F
X-Rspamd-Action: no action



On 1/20/26 17:44, Alexander Dahl wrote:
> The OTPC Control Register (OTPC_CR) has just write-only members.
> Reading from that register leads to a warning in OTPC Write Protection
> Status Register (OTPC_WPSR) in field Software Error Type (SWETYP) of
> type READ_WO (A write-only register has been read (warning).)
> 
> Just create the register write content from scratch is sufficient here.
> 
> Fixes: 98830350d3fc ("nvmem: microchip-otpc: add support")
> Cc:stable@vger.kernel.org
> Signed-off-by: Alexander Dahl<ada@thorsis.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

