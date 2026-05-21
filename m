Return-Path: <stable+bounces-253526-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCpYKq0DD2pDEQYAu9opvQ
	(envelope-from <stable+bounces-253526-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:07:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F63F5A5655
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FC2930DF9CA
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780033D8104;
	Thu, 21 May 2026 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2a596D4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9D63D7D66;
	Thu, 21 May 2026 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368166; cv=none; b=kUUjjl5CRSelHBokwPwviomZSfP5GT4ngWKXue5y4PeWxNRn3b7sHzh1KYyY+e1zphgpLuOvfJ+2CBi6WOOpT9FLkoZBvqZ8unMwSZtiO9pCk6H8mPjVxuHVnpRHpGKz9y1sT7nlgu2V4a+fQeAUVWeZgIlsBg0l/HNkbe3zrMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368166; c=relaxed/simple;
	bh=nJik46eEYfsCg2hdV4+nyfsSrm54MBpbXPIsthiHv5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXm4Lw87QNlwj7ce58CTASx7/RFa/901wR34lP0xVv2md6MAvCO3NlBmwnPya6t9zrelxl3hdUFEF2S11y2TBlUpbi3Zym456xrQIPgcBCRpLMy6ibX1v12ug8WhdnEcl2n22QCoNTOpqiBPEAn5woocRNEPlZG2eY1iCV9SoRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2a596D4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EBC1F000E9;
	Thu, 21 May 2026 12:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779368164;
	bh=nJik46eEYfsCg2hdV4+nyfsSrm54MBpbXPIsthiHv5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D2a596D4nBGte6R81CgY0XfgzbDebOQuHfMpUM/sUIvUR9ns76lnUPELSi4vvMnlR
	 w7Asou8tm0Ly+uPh6beUSE1E8K3n2YwAvKzL4QUfvMjRRMi1/G8ePqZLF4ahRa/M0W
	 QzvLKj0lFJzGwDUtnqhVT/foSBL7aygYB3MHSJZ5fXmoK4Ybr06MD8/cDxdxIAG7UZ
	 UXI49fXpsRyTiaNGiy4Vw4iKUUKczyWhMrplH5+SrRx9UyBJZXPRXqXG/UZ1XLcy0p
	 CiQ+Si8vuSEiS3nitOduTA+6TKoArIF9dc3E9o+bIwMOwHxs75h7Q1w5uOv6GumncJ
	 /eKTkREcC/4kQ==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Amir Goldstein <amir73il@gmail.com>,
	Chunhai Guo <guochunhai@vivo.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Gao Xiang <xiang@kernel.org>
Subject: Re: [PATCH 7.0 0013/1146] erofs: verify metadata accesses for file-backed mounts
Date: Thu, 21 May 2026 08:55:50 -0400
Message-ID: <20260521-erofs-7.0-drop-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ag3qlMOcTYM2FBUQ@debian>
References: <20260520162148.390695140@linuxfoundation.org> <20260520162148.691068692@linuxfoundation.org> <ag3qlMOcTYM2FBUQ@debian>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.linux.dev,gmail.com,vivo.com,linux.alibaba.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253526-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0F63F5A5655
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 01:08:36AM +0800, Gao Xiang wrote:
> Please help dropping this patch from auto-backporting flow
> since this fix commit needs another fix, but Christoph
> doesn't like that fix so it never gets upstream:
>
> https://lore.kernel.org/all/agF0wJSFRAEcRP8M@infradead.org/T/#u
>
> Since it impacts Android use cases (SELinux), I will
> backport this manually later, and for now not backporting
> this won't impact any.

Dropped from the 7.0, 6.18, and 6.12 queues. Please ping us when the
follow-up fix lands and you're ready for the manual backport.

Thanks.

--
Thanks,
Sasha

