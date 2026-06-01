Return-Path: <stable+bounces-259411-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFlnKV3qHGpWUAkAu9opvQ
	(envelope-from <stable+bounces-259411-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 04:11:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EA8618C0D
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 04:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 470DC300E269
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 02:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3775A1E7660;
	Mon,  1 Jun 2026 02:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuDNdOwW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A5F20468E;
	Mon,  1 Jun 2026 02:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780279897; cv=none; b=PRHfwv2qvzZE8S3BAgVrh9TqVXWwwH3hva8urqkO/j1h1G4ohxpgAHlgviPQb92MyVuON3SocBGxF2UMkAkst1n0pSOPpRj+58ZQ3+2vkFxcdX0W0CKCr6x/m10eBjotvYT0gfBfbPEaiqqv/IF+9tji0vM+Qdc88YDDpCKAWEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780279897; c=relaxed/simple;
	bh=6hW86zlebySrbdjIbjFYkybFpXtTVTUuR61ICRnin/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A91WZ59yZCEZfhAKktBn14NMwwt7vibnAXcygJ7oD6CHvsmPsaDPhdA0XiUi5zWM7BwZ/Rla8xD06VquOhpeuyESTRttfCMPPVSpJA1rwPs9gMMqi6VL07N6V+D850KY++ZdhRddrrpmp8CblPy1y+RnY7UgvW12hYllplullF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuDNdOwW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62FB1F00893;
	Mon,  1 Jun 2026 02:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780279895;
	bh=yPtqoN5Z39aMqZowrbWq6GATWZsPrGUmuolvjnFAHFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UuDNdOwWVDuqW+nT5mR2U1URzLEWqOAQFl8yEOB2JsbYXQnq4eTxfzwgPMcsXRj5h
	 6f1PJKfSzNqIu69oCVksJMB/TSM2AB59hSbKlFTcMkkL06B1pvgng/maCq8ozBL4xu
	 quhozSfK9Yz4fin6gmNUNlwhpnJtFs8sYXeFiqvR0ZVTJi8CvyecKnlIKd3zBc+N29
	 yojk5pAT2sMKKnk7zGm6qRTMkzaG6uTERkhrUtAnMMy6+nlDhDwqgHPHRY8Irew2iL
	 rB981kOcFsRXo/8VunYE75b0u5K2AnpXQfJKpRtTxn1CZLZ+hOIwKmHrp0la6RWe8S
	 QYDgUmBl51ngQ==
From: Sasha Levin <sashal@kernel.org>
To: Ben Hutchings <ben@decadent.org.uk>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	patches@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel=20Monteiro=20Pires?= <cassiogabrielcontato@gmail.com>
Subject: Re: [PATCH 5.10 002/589] ASoC: SOF: topology: reject invalid vendor array size in token parser
Date: Sun, 31 May 2026 22:11:20 -0400
Message-ID: <20260601015021.rc-asoc-sof-author@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <a6df0003-8be0-4663-8753-4e28f4cffb1e@gmail.com>
References: <20260530160224.570625122@linuxfoundation.org> <20260530160224.642881938@linuxfoundation.org> <daa0df3788560bd8759418d9c333e09c45368aa4.camel@decadent.org.uk> <a6df0003-8be0-4663-8753-4e28f4cffb1e@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,linuxfoundation.org,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259411-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 59EA8618C0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 2026-05-31 at 19:32 -0300, Cássio Gabriel Monteiro Pires wrote:
> In order to keep the minimum header-size validation but force the comparison
> to remain signed, I think we can do this:
>
>         if (asize < (int)sizeof(*array))

Thanks for confirming. I've dropped it from the stable queues (5.10, 5.15 and
6.1).

--
Thanks,
Sasha

