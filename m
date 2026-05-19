Return-Path: <stable+bounces-249472-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMkiK1UIDGodUAUAu9opvQ
	(envelope-from <stable+bounces-249472-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 08:51:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F93B578608
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 08:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B6EC3065069
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 06:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E5939DBEF;
	Tue, 19 May 2026 06:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="szNMMRbR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439A239B4BE
	for <stable@vger.kernel.org>; Tue, 19 May 2026 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779173124; cv=none; b=NOfcH9OlRcDhfo0zjr1k7uRmZb+LFkezdC8Be9L2sXOPFCcCI8J559AYQ61c/jQa4DslvZ+2OyIM1cIHbefCmCkHnWZ48Yp7y9fsPcRDZhE5qbBrrmt4/E5cJ6FbW9ehdMnW1bK0mqsc8ODFKsFBxJ7KQB4AFQCYHtnoGeGkRYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779173124; c=relaxed/simple;
	bh=UOcuMTpdbzoPX4wfvaURAgMpzn1YqSDoIYupHwNwy4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsYRxia+cqrqbksTP4GRFDrtu1yDjSzQ1VBp0B3Aua4L09Y60nODM8d1+n2j3bVy2GnwX70sRmESpPzPXswWaE/7IDAkM9tzkUWh26MRoXvpfUjQ7othQqcxS2R2W5QcLFww+/foVatoIukeH0V4WlenEcOjN6MZFSdzhpCozIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=szNMMRbR; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82fa8d6425bso1408979b3a.0
        for <stable@vger.kernel.org>; Mon, 18 May 2026 23:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779173122; x=1779777922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9tSJoOKg/vW50+p43BRksSfoFvz7qTykVby+kYZtXs8=;
        b=szNMMRbRvVGOY2b/MA7V4hhZy4HvHYiULKiwDPmcjPb19BUn/M+63ftLjOdtjwdc8w
         7zNvTAynRJJoQ0oKG9cdpo+I/1tdRgf6kSQiBlpSlQ0dBDMZ+uQLEkvHWFx5X9TKjtZi
         Qevw/hXAFNbEkA26/9GQ8eq23E7f8P80m8HrqBkW+F4Ca8uyuSw+k0DMciczpF27StLi
         Y/tagLx+d8S2ogSWn0cilU02qMhIviodjYfgH6VQG+2ocg79HLstCndE2x/aanvG9XEc
         W8v/XWcBo8UddYROT00S+YzRsgh5j3FMayx7VzELJwri49fEIje/N8F6HO+R36ki96mO
         bXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779173122; x=1779777922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tSJoOKg/vW50+p43BRksSfoFvz7qTykVby+kYZtXs8=;
        b=DNwknzHe/tpi2pPUGWt7GOGoxyV6DIIolVw5EFg88llJhk+MqonbIQ+npZFsF3aOcp
         w79/O9KHdZww4F33L2miLRSCstOKyU5VDo5BKRjiHUXnENQUv1vTWPK3iPLNJqqgW+Zt
         kgd6B7c4YlGE6uFsSxImgL5y1jJXQ5B0CCzejitiToelqv9M7wZgjmlqo7cdMYcqXQfk
         VO3eULvG9bAdqChrfj1h38t/+XUU6jNeH2noeeVHtGJbVdKsm0hUyLzOty1aIoXfkrwc
         BJNQAwwWDUlZwhu3jWVcczdqY6EzXBljTXLFZSdtrNyR0ebu/4z0iqCT5wud4YDtYr75
         PUPg==
X-Forwarded-Encrypted: i=1; AFNElJ93ExrFunWHQsv73vM2Ibf5mRh4+2OA+Z5mchTJ8HdAX/fBszBLrPU5SQ7M4lowv9wA1DyLcCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2iODZv2MZHZwcTXvy4wJDSVq/5Cf6mkd8B3srelq8BPArvqHu
	6tTdgGYDdpH1h/R+JPbzx+OC5PeJZhKpTp1C7rQEUKhEirc4GJ7b3j+r
X-Gm-Gg: Acq92OHZLlKD1jUcgnWwqQxYGhRnKHuRERLMuHgFP0GtBFNdH2HKu092qZqJUYgf5zk
	Tzrf6QUkV9L+Yp/v8+3Xl3/fhdI772xP+Q5adaVXfvXCAaVZQ1WZj9gPfZHtYYhEE86O9pALi+N
	ZD+x/SZYIyo5OB5Eg5STBxatxRzpI5r9ujwPhMQxPpz+CSQJQ36E7SkEU5qLO64JrgjWnmzjdgE
	BXl2mDHw35uGvaOcZPteUh+vgmk4kDt1YYNEoEpLKQEmCArX0buHSNY2nU/eAY3v9husH46fXZT
	RWrAiqZ4GI5wCaEaFQjKSc/oUpTZ4mC8fXIs/g4SUoQd+zE7N3kUv1JOdvs78UzlnpSfWJIvp9d
	Bih0G2alHw7hP1PakXaAnv9m7/BEGuLgXPVt8/P6Yq/8mst5RQtrLch2nY7L642Gdqt7dFzPb9u
	fISH2+SoJ2kOUdu1C948uuH6BcnMtZyt8iJv38VJUNPk4=
X-Received: by 2002:a05:6a00:4484:b0:829:8cfb:df45 with SMTP id d2e1a72fcca58-83f33c99b07mr18066494b3a.15.1779173121683;
        Mon, 18 May 2026 23:45:21 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c78844sm16002649b3a.47.2026.05.18.23.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 23:45:21 -0700 (PDT)
Date: Tue, 19 May 2026 15:45:16 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Cc: aaron1esau@gmail.com, ben@decadent.org.uk, davem@davemloft.net,
	dsahern@kernel.org, edumazet@google.com,
	herbert@gondor.apana.org.au, horms@kernel.org,
	jiayuan.chen@linux.dev, kerneljasonxing@gmail.com, kuba@kernel.org,
	kuniyu@google.com, malin89@huawei.com, mhal@rbox.co,
	netdev@vger.kernel.org, pabeni@redhat.com, sd@queasysnail.net,
	stable@vger.kernel.org, steffen.klassert@secunet.com,
	sultan@kerneltoast.com, tanjingguo@huawei.com, imv4bel@gmail.com
Subject: Re: [PATCH net v5] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <agwG_G7l9gdT0BsH@v4bel>
References: <ageeJfJHwgzmKXbh@v4bel>
 <20260519040232.1395-1-rajat.gupta@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519040232.1395-1-rajat.gupta@oss.qualcomm.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249472-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,decadent.org.uk,davemloft.net,kernel.org,google.com,gondor.apana.org.au,linux.dev,huawei.com,rbox.co,vger.kernel.org,redhat.com,queasysnail.net,secunet.com,kerneltoast.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1F93B578608
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 09:02:32PM -0700, Rajat Gupta wrote:
> The skb_gro_receive() and skb_shift() fixes look correct -- we
> independently reported both to security@kernel.org with working

Thank you for testing. When did you report it? The two PoCs were 
already public.


Best regards,
Hyunwoo Kim

> LPE exploits confirming they are exploitable from unprivileged
> user namespaces.
> 
> Could you add the following tags when respinning or applying?
> 
> Reported-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> Tested-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>

> 
> Thanks,
> Rajat

