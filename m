Return-Path: <stable+bounces-224746-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOKbCfK4sWmxEwAAu9opvQ
	(envelope-from <stable+bounces-224746-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 19:48:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 259C3268DA2
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 19:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1AD6230209A7
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 18:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F6D3EB808;
	Wed, 11 Mar 2026 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="vbnC+Vk3"
X-Original-To: stable@vger.kernel.org
Received: from mail-244118.protonmail.ch (mail-244118.protonmail.ch [109.224.244.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5B33EAC93
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 18:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773254841; cv=none; b=notmN4JN42ODF9rkkEh1h9sdLFaKV9Abshn7nMz2zttHU+0tGRzBjX4ReG5mzgFyAVdV4FhhYJ+MXt6mus3HrfjkJ5tuylk5k4JeIQxtE6fRmpqdxboDS+prr8hKSq4LTTrMWdhRpnZheufDSrkem0WqulyxlWp3TJhr+9cCkEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773254841; c=relaxed/simple;
	bh=Jl7leThxnp/lGPAmTErmrNimY7QkLMfU1aZqqvKoU40=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QplqQjbETtWA9t4HJRqfhOr8i+l/2zmjG/OII16trxQKNs/17bQtokF7cAhG3SOyEtrXOpHXvMUWQ5quPNtaY9O+lJqH+LwrlSFklIVlrfxgjQSwelt9fAccpVQhWMVsOjWBwQfWrkQNiKo9bvMCyV9xOlqfGi30NYRtu/SbY1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=vbnC+Vk3; arc=none smtp.client-ip=109.224.244.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1773254829; x=1773514029;
	bh=Jl7leThxnp/lGPAmTErmrNimY7QkLMfU1aZqqvKoU40=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=vbnC+Vk3tCDm99skCrj6obm6wxp1HQZt8aS+bc1z+/aa69PTErRtp37kWoM/dpVVB
	 7DTxpUUJUyhq9vyAbZlPRzCS3vI0y2P/MV9zlLr8w46e9aRzNmnXMFwy9GCZOvjopd
	 G9k/kfyfCnpZfRwP7ppQRnZrQfqI1aAgG/2xw41rJF7kdoLJzMJEaI5x9Uvm/nQpnW
	 E8ovvpErJJTYcUvpj4kJ7UkO78UYQwYZv9B9LsZugaII7tKsN5CDN6fVBOFHwra/7K
	 3PQxI1OrJYbkTox3ccDj0Ix8wwKLpfh2y/oy+YcldZ9erwpd8v8vhUeoSrPYNXexNU
	 dq2Sq47WAsbnQ==
Date: Wed, 11 Mar 2026 18:47:05 +0000
To: Simon Horman <horms@kernel.org>
From: Paul Moses <p@1g4.org>
Cc: edumazet@google.com, stable@vger.kernel.org, herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, steffen.klassert@secunet.com, chopps@labn.net, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [net] xfrm: iptfs: only publish mode_data after clone setup
Message-ID: <gMKu-eP2Z17VRGWDt3UsswTDUTaUJjm9BDstYEsXaGoK7ZFwEFDiflQT85gbZ1IiVx2mjZ09xI6Mn72M23V-3oYTNL8nMgb112XEGMoXcJY=@1g4.org>
In-Reply-To: <20260311171134.1134085-1-horms@kernel.org>
References: <20260309173033.537743-1-p@1g4.org> <20260311171134.1134085-1-horms@kernel.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: ffd8969943b7fec8d286fa5d2d15212eda546b76
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224746-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[1g4.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 259C3268DA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

>=20
> > Fixes: 4b3faf610cc63 ("xfrm: iptfs: add new iptfs xfrm mode impl")
>=20
> Should this Fixes tag point to 6be02e3e4f37 instead?
>=20

Yes

Thanks,
Paul

