Return-Path: <stable+bounces-225721-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CZyLqaZuGmsgQEAu9opvQ
	(envelope-from <stable+bounces-225721-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 01:00:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECFA2A2257
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 01:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEA2C3055E62
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 23:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE67379EF0;
	Mon, 16 Mar 2026 23:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="bp3nPlbV"
X-Original-To: stable@vger.kernel.org
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch [79.135.106.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B9B3783BB
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 23:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773705566; cv=none; b=q7+jCK3KjhTZpRHMvKC4DEun3Eigs3nPWSx2F+rRqpCK9trXLDS8ssCcSTtnQPhCjwm4jUd/6HE1wGFnJMxxZFVLqVbxIVfM+pfyXW1KnlUlHfBO2DOMjv39fevkL6CcfrYEkLny/ga+CYUuUDBDYy/A5KNsxflu5HkIxHd1lUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773705566; c=relaxed/simple;
	bh=L2FJVvoEporHcYqOd0eo5ZF7DRaOACwGLwAqOnbjmsg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OowBfqY1PRKCnIuY4inm8lOAAGNaSwupLVKFUlOXzgJswAl1ZjI30wY14BsEeMTDu82hzVyZmaLM8yM3KwhOUZPo7AerXIBIUaJTEtNw+WCA/nW6k/xQwAFxmj0ym/fgiKtyveWnktKcO7eDOkkLZpBlNdXIDSvXI8VGPc2fQro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=bp3nPlbV; arc=none smtp.client-ip=79.135.106.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1773705559; x=1773964759;
	bh=L2FJVvoEporHcYqOd0eo5ZF7DRaOACwGLwAqOnbjmsg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bp3nPlbVmyGqM48Jial+oojfjDRawvSi15dkq2qoX0velVH+YrPDv2FcNXObJAD+z
	 lx/nY2NCfmJdiaLTIp8YBUd+4VwdS/2iEzMZhsuoR1a65Q+yk3ayExUM4OpBNx4Mr5
	 P+jphX2RajTeK37uZKBoX9Jy3W1pAalzBw9Q43Q9tkkbccsVUdgYFjx4CKWYF9xvgP
	 cSzCW/EQCshDI+OjAe4tbHxbzCTcVdT9Q+YIHnFDzQ2rAUc5KBVIl4asFU0/qpFnpC
	 PA0gOYyUQFzhJZbyKa8PWZRC/ornVzG1HSiXuW6z6QLltRlZu3WbnI4DK5q5uAAlJg
	 7TigTwe92ql2w==
Date: Mon, 16 Mar 2026 23:59:15 +0000
To: Jakub Kicinski <kuba@kernel.org>
From: Paul Moses <p@1g4.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net-shapers: clear hierarchy pointer and defer flush frees with RCU
Message-ID: <Z2Z1ZHOKjrQYZq0NtO22IyUBriDT4l0Ek6pEAsTI5TRfETvY8pWlxuNXCfBaWdbH0daZqJ9Mcpp1PC2533-n-0oe07uPSvsUmWFLjYY8tg8=@1g4.org>
In-Reply-To: <kml9JrxcP_XGGG4SSCVJO6f8Oi9zTfdJg9NRVZyvu7YAd5dgDy-uBE2m1U6MVY-ponQRFLuWQ6z14W63DCLevPICexEWX_yMQcZrytxCgDM=@1g4.org>
References: <20260309173450.538026-1-p@1g4.org> <20260310192842.3c3b2070@kernel.org> <hHYLQqDrBCcK_2x6uSbGsBott3QuXe8o-R9tj4vNmw8UUEFxpzoD_PCMiHMyyOnySAtQbJtCAB8yVoCmWxzO07C02Q5o0J6fHu4NLEa-ggY=@1g4.org> <20260316161247.1f472be5@kernel.org> <kml9JrxcP_XGGG4SSCVJO6f8Oi9zTfdJg9NRVZyvu7YAd5dgDy-uBE2m1U6MVY-ponQRFLuWQ6z14W63DCLevPICexEWX_yMQcZrytxCgDM=@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 5d1dae45646e1df27042648a257911696d7ac663
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[1g4.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225721-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[1g4.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,1g4.org:dkim,1g4.org:mid]
X-Rspamd-Queue-Id: 1ECFA2A2257
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This will conclude my work on this module unless another high severity CVE =
presents itself.

Thanks and good luck.

