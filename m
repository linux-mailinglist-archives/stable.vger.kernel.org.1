Return-Path: <stable+bounces-244946-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEptFfIs/2mT3AAAu9opvQ
	(envelope-from <stable+bounces-244946-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 14:47:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD924FFA60
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 14:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 342EC300D376
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 12:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EDC388E6F;
	Sat,  9 May 2026 12:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2b/2PZp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D94388375
	for <stable@vger.kernel.org>; Sat,  9 May 2026 12:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778330852; cv=none; b=I4oXLAGsGOCs4ENu+hBVze0vCcFODHyFmRD7DfMYP8xTAKsveWCTEObiHtX8asUMNFqHDL5+9/A0sZ5gui4Ete2VPk0rDCxdnPeRcux4FrVFYfu/f5a5EIUDo5WEYSsj/5Uy7afhhnhzqbgpraDdEe4Qaw6J5UMIA8XBw976sqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778330852; c=relaxed/simple;
	bh=nIr/N/sQ0dod2ipSHnHzDnOLcwgB1tHkTbcLZ/dC22g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxSIvU93QYA5KgmA4V4+gOcXZol0KQLdXPN735LvyyNb05DbsjGQ59M74VaXPP80EdHBkBfUFu9oV0OYW2pGiMD4iRTXnrdYExOTEcU9OcM/DzHwvye77qSJE4ghgiN20IBiU2sAo+FlEhaEmEt9QfXeshehwpnSfqHrF2wUXU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2b/2PZp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52659C2BCC9;
	Sat,  9 May 2026 12:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778330852;
	bh=nIr/N/sQ0dod2ipSHnHzDnOLcwgB1tHkTbcLZ/dC22g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p2b/2PZpDxBAe43BV1FMyoyphT0uwgvFBTRLy6Q8HYPkyXSktCmjvfXU6xO/lK/7c
	 9bF7vORF4djZ7EFv2w+7HxOZ8BisNXpfmSnm1zUgDRYoYu3Y3mb/QyqdiA+mqERftI
	 qwPa3LNPKZp/P7MD/WqcEC4zjs8HXZnHGdx71dXtxsWcn7SH9QxMSO6lX3IskLuu40
	 IldNCx1FVUZ3cmtYGB2yE6Yn5FFgd61Ktb6upMNPO4WrA+a6uyZo7aKMhFEyVGI4lP
	 mC/46dDvR6ZnIkqe3UR3ZfqW7PPbqHZkIulTp1G6kd28c249IEVobm2yW04Qxb0kZE
	 giu/A4w0rjt1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@kernel.org>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: Please backport d6c19b31a3c1 ("flow_dissector: do not dissect PPPoE PFC frames") to v6.1+
Date: Sat,  9 May 2026 08:46:55 -0400
Message-ID: <20260509122858.b7601671432c.re-flow-dissector-pppoe-pfc@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506064410.295564-1-qingfang.deng@linux.dev>
References: <20260506064410.295564-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4AD924FFA60
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244946-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> Please backport d6c19b31a3c1 ("flow_dissector: do not dissect PPPoE PFC frames") to v6.1+

Queued for 7.0.y, 6.18.y, 6.12.y, 6.6.y and 6.1.y, thanks.

--
Sasha

