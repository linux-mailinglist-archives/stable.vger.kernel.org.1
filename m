Return-Path: <stable+bounces-226916-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHxeCBXNuWm6NwIAu9opvQ
	(envelope-from <stable+bounces-226916-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 22:52:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFCB2B2DFA
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 22:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E1F53070AE1
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 21:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FCC306489;
	Tue, 17 Mar 2026 21:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="McNzcTmJ"
X-Original-To: stable@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042DC2D7393
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 21:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773784338; cv=none; b=Mvjz5Ffmg/CfkP/P/VNe0wGzFLBgHGRrwUdyJHAsz1h4WyjaAp+yVYKuWD+n5BIxGLtgONJn9NnPlFAemNDZGa0yA74b5xm7e+9K4k9vhSoc24bRuxkKySV/u8D+ZBemJ/k4HXnemulFkcrCa0JWZsmxeGLG/brV387HdFycbyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773784338; c=relaxed/simple;
	bh=b97wXvolFR+e8uTxUV44AIrk4klW4uv/w8rxmuRBTvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BrZ4hk69jAtHxtjK1k7zqtgDe5uiu69T2UNB0SJsg7lyKqNv+/upnjCujdXxQgr0pdbWl8qRuAGFBqbYkORp88Vju8JrE5GLnnxxn2jvkNW2sd0A6bPAeOQbHFo7ZJpxOep8cL7zgAFOoXhflSPYi9xnJQoCdivFZrjXz2Hvq08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=McNzcTmJ; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1773784324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b97wXvolFR+e8uTxUV44AIrk4klW4uv/w8rxmuRBTvM=;
	b=McNzcTmJC/2il2UOCI/lu+tEQ/UnzmIk/CqheZbms3XrfXVudpE2Sqp1z2HIv5bVLqwZb4
	SJhalPo3N3PXezbvWJ3XLI2z8fAuvTpyJNRO3iJRcXdB5SYKMQ+ICd82QhaPJIzGuSaBUx
	f0R5GIaoRWO51l69I3uR1RZSknF8vtv14benj6MKNUR/9ML6i2Pkr4jDCfUtI7g+WMMOfs
	OeN6b9tzCB286cOHGF3wIz/md6LNP3rmjwWuvWVaI4ZB5qQ4ON0S8cGVjn9meD6IPsPYCL
	wYiSYjMv79B/FxMt5xwg+oV5kSD5KUoB1Lr7Hl7csz/3dQT8oCy7iGm6EgA4Pg==
From: Lucid Duck <lucid_duck@justthetip.ca>
To: linux-wireless@vger.kernel.org
Cc: nbd@nbd.name,
	sean.wang@kernel.org,
	lorenzo@kernel.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] wifi: mt76: mt7921: fix txpower reporting from rate power configuration
Date: Tue, 17 Mar 2026 14:51:58 -0700
Message-ID: <20260317215158.152921-1-lucid_duck@justthetip.ca>
In-Reply-To: <20260317173016.136975-2-lucid_duck@justthetip.ca>
References: <20260317173016.136975-2-lucid_duck@justthetip.ca>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226916-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ACFCB2B2DFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I missed adding the stable tag. This bug has been present since the
mt7921 driver was introduced, so it should be backported to maintained
stable kernels:

Cc: stable@vger.kernel.org
Fixes: 1c099ab44727 ("mt76: mt7921: add MAC support")

Sorry for the oversight.

Lucid Duck

