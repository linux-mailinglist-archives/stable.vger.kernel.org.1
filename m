Return-Path: <stable+bounces-249475-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sICANWYLDGo5UQUAu9opvQ
	(envelope-from <stable+bounces-249475-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:04:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A7357896B
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5958309152A
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 06:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EB03ACA7A;
	Tue, 19 May 2026 06:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMGNC1kG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87D83ACA72
	for <stable@vger.kernel.org>; Tue, 19 May 2026 06:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779173878; cv=none; b=c7Bbi2PiY8j+wQ5UAsqm24cSlp2Gsb1AQv6fEGTq1Sz4HoW5RLNkbNUNAd7OULqYByUou1WloREDLrycMpYmJp9T8qCGWdkyeyUo0+8jASDDr5joGTEUYp1Y38H4Ds/O/YvyDuE2zoSpWcxdCPwpGEM+qjVRIh5y/9rUDQI+90M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779173878; c=relaxed/simple;
	bh=LhRcyosxtfl7pBM3FQKJQNYHIxd3v8xS/E0vghKZGPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j92Bnm3bUPlbIYsMpCV/RM1Zle+BmWe9CcnnJ5yTF8fQTMgsBNxwwzYcZbw74JznwRlExlDo7WtvWOkZTk9jE2mJot39UJ5g1gmw6Y24UK4uUlZN3z0pt86RXjMVbdiD6eSpXzAtU1UqaPXfA4bPHZHuwlQKl61IUk8Rq5qHH3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMGNC1kG; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36608b2f2dcso1807382a91.2
        for <stable@vger.kernel.org>; Mon, 18 May 2026 23:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779173876; x=1779778676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ermnUQZ+hsf72YdY1c8AhCxZM8Nonb3N9ICT3R/+dBY=;
        b=nMGNC1kGHjsbQlONyrX8wce6NmPVXr7iGJgdJ7KjmB0GrEwUryiSBy05hApUzeCBUx
         wUZaUwDSdRJoo2mn4YqW/kepsyb5fwtKsfohuddArPl119kqPqQnx1Fl6ilQwoSfW5bk
         lvEV+rTTD9YDl2lBTB2ProLbmPtILWhi7KA3hkIeleK9UBR3bEytSMYPD5Hi3vnprKzB
         Vg54B9TVflu667+EOQmZZFTlV3F7TcwewECQeERJu6rReRxGBt1EoYseaPC4LUe1oIn+
         KbEyIBFO51iC3/JRoouswN1ic1tbR8mo62tlZIOWyrrj9Xwmswyb4qTgEhOkgBo8GzRI
         fxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779173876; x=1779778676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ermnUQZ+hsf72YdY1c8AhCxZM8Nonb3N9ICT3R/+dBY=;
        b=Mfiuz3mgNTw1BRCUAUvPjRW50boCj9eIfCGTuwYi1Z2MYf9dPaAOZHi7gfLVxGhudy
         iINPpbfOfwudhZqklZwXG8RHuFgv5l8gIeBTWQYRI7yr93YTk6D/+PKmT+NzB/IbUzwR
         Ip1cut94vcqbkEeRDtGn1c2HJkuS2f/tii/hGZ6sf1DAtF+BvzeItwyxt2p/3r//1Md2
         iqT8gu+lNq3V2kN6hj7qX6W4YyOk5+eqWI+naxUGq306xXy9f5yNKtQZ8iKpcxRxWoMY
         GSdLeKkTvsKZBWEjcLLzaEQjFtfe4I9a618IEfqRCBpB8O8IINa6jcjgn+B4wG3+Gu8y
         aVxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/hgwlLyuMMhc4+cOOeVrEvAIkw+AhB0DzYUxnzEMo0TM+wBz4frV25Vv60CUcwbY4Q+q7nT3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YylAD6yv7D48lYTJAKzp+pQCEe0nB6+qPIQyCAQ4owfLGCUELel
	N/MIOcBKldMZsabhjZ2gEuZix73fNFBM3/dm6nCn+lTwORECRg1JJa07
X-Gm-Gg: Acq92OFgnAFOZPhDOp4KDt58rf4MjsaKzlwBZDAfRAfwtM8S38UCvdWGY0TgCZsRnpE
	MVU9ici9nouxS4TEbeH60epVx/IswXQ+Y3s24eFNLYADQHqO6oKPB5bCmhrhv8Gzjxx06ht0GtG
	FuyVW3khlUEA/zyL46ffuoMHj+Z0POd0QgTnqJzbIbfY0fjv1QtCDkz/UReJBUm+sWAAEtFwqgg
	6wkKGydqIse/Div3rMonHcP8TC7e20WuWVPGZ8bHQvTx39XCanLbyUmBPmh9DV1e1Xn5l/wyc9/
	yOrW13JvlPJZGr4gQ0iY/zthJdZlxPZJY+27cizVVXcDAl5xkI+421ejeAa/JWsg+dN1G/5B8Tz
	VoVEGLtOBNIhfRV+CWU0GUKiQxwtbggi0u27TFIcAziituV4sNmEFTpE+eFHmbuwKyU47kjlZ24
	BcRIPqWzYNxbtTCrCW0/KxLbEzdQz/2nZcbg2/blQvahg=
X-Received: by 2002:a17:90b:48c4:b0:35f:d56d:1c45 with SMTP id 98e67ed59e1d1-369519cc92amr17754746a91.12.1779173876068;
        Mon, 18 May 2026 23:57:56 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695157c3cfsm13451610a91.5.2026.05.18.23.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 23:57:55 -0700 (PDT)
Date: Tue, 19 May 2026 15:57:50 +0900
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
Message-ID: <agwJ7kbcmJDdLYy6@v4bel>
References: <ageeJfJHwgzmKXbh@v4bel>
 <20260519040232.1395-1-rajat.gupta@oss.qualcomm.com>
 <agwG_G7l9gdT0BsH@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agwG_G7l9gdT0BsH@v4bel>
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
	TAGGED_FROM(0.00)[bounces-249475-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 57A7357896B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 03:45:16PM +0900, Hyunwoo Kim wrote:
> On Mon, May 18, 2026 at 09:02:32PM -0700, Rajat Gupta wrote:
> > The skb_gro_receive() and skb_shift() fixes look correct -- we
> > independently reported both to security@kernel.org with working
> 
> Thank you for testing. When did you report it? The two PoCs were 
> already public.
> 
> 
> Best regards,
> Hyunwoo Kim
> 
> > LPE exploits confirming they are exploitable from unprivileged
> > user namespaces.
> > 
> > Could you add the following tags when respinning or applying?
> > 
> > Reported-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>

These issues have already received many duplicate reports to 
security@k.o, and your report was not consulted in the 
preparation of this patch. 

A Reported-by tag is therefore not appropriate.


Best regards,
Hyunwoo Kim

> > Tested-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> 
> > 
> > Thanks,
> > Rajat

