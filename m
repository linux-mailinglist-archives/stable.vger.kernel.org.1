Return-Path: <stable+bounces-254360-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAlhA/yjFWprWwcAu9opvQ
	(envelope-from <stable+bounces-254360-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:45:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A61905D6C6C
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B3C4303B52A
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4231A3DD52D;
	Tue, 26 May 2026 13:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDPJ5MWK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F52F3F9F4B;
	Tue, 26 May 2026 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802706; cv=none; b=s8a1aVkWN6NaqPgq9Eo3F/BO74LSoT0QL6J6MQNVt6ySd8BjmX3Qc27Rgfh1RH1T3TMYvOxYnTgHf8uMFBsdhyF+x0OzhJIQl5Qq/lJKb5WCnfUIuEHuJS/abprO3Q/gicIJDYvSYbA+qSD6vwgLTSvfNtxC0O7exMXmcvhPSag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802706; c=relaxed/simple;
	bh=dURfg/COMAxPqFQUIu2SZA+jkPDqFqRIivYJZhTkGfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eU8HvvZtr/XdhJ0fI6qVfYvif+W1kFLdWJHOthjs6G+07q0x/TN3kGpa2/A2O25fFOdjhi/yfPt1jrg6pYB21zITfErkzqmwScTPfYsjl17vT7n83DO4+M/V5axLPNc4AfDPYFR3lzgqveYLMi+z8gaz8myb5cMblHGNaccSvEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDPJ5MWK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E171F00A3D;
	Tue, 26 May 2026 13:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779802704;
	bh=fbJngTErAK0sml6KeET1aCut6ER6c6WTjHUwScptdOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RDPJ5MWKPfHDoWQJd30l6hoIU//FP66C8aWuXJVpSN1vMOREo0LrvfV5YjoNNnIT1
	 rK2SlsVbzbUmDjBkXx5uyinJns1g36bSVAs/dhZxSvap4yPC39ZkGg+UPHBHvm5rdX
	 QsKuf85FwsHzkXTJNkBK7rZCToXvBmBSj0xqA7TbbZMamM3BdVfQBS7kOCXOqMbENU
	 moeCqPyHH4oEpH8BeK0HL/aLDT85BEp91ZDrtsEm7AGAnqmd3r3TVBPDK4AatCdijh
	 0l/W2xQvMEBzzSbtouCrJZfoUTDz6PTdWgr/Euo+NkPJ/8/ELRMsxCakuGfWHEQrkg
	 mSJ+Z1x7GKmsA==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	linkinjeon@kernel.org,
	stfrench@microsoft.com,
	d.ornaghi97@gmail.com,
	knavaneeth786@gmail.com,
	charsyam@gmail.com,
	Alva Lan <alvalan9@foxmail.com>
Subject: Re: [PATCH 6.6.y v3 0/4] ksmbd: validate owner of durable handle on reconnect
Date: Tue, 26 May 2026 09:38:14 -0400
Message-ID: <20260526140000.agent5-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <tencent_03EB621C56988886195ADF9AA78F33494007@qq.com>
References: <tencent_03EB621C56988886195ADF9AA78F33494007@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-254360-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,microsoft.com,gmail.com,foxmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A61905D6C6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 03:57:01PM +0800, Alva Lan wrote:
> This series backports the fix for CVE-2026-31717 along with the two
> prerequisite commits and the follow-up that closes the scavenger
> races (KASAN-validated).

Queued the full v3 series (all four patches) for 6.6, thanks.

-- 
Thanks,
Sasha

