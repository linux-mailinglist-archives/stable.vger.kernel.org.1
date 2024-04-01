Return-Path: <stable+bounces-35503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F678946CA
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 23:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F7D1F21F6D
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 21:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7246954744;
	Mon,  1 Apr 2024 21:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Jk6yobiL"
X-Original-To: stable@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7303F535B7
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 21:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712008492; cv=pass; b=MouNXD4rdhN+BWG1drIMfmiGTPGYpKFo+ijiK62roQPitpMFjwU6yaa3lQc04OHn2Ff0LD5sZv4k9GF9TMWtxgpwyb9S2tKm0Jhp8lIbnIW99LzEa72oLpxng0eXr8CE2CqVJ8t0AUMzrDJsSikDg8PfFodddJ5vIRX39P6GaP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712008492; c=relaxed/simple;
	bh=ZaV2XdIdXXgfbvyLJ86RFMi7lqiINDbol4NjQwBVF1U=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WCnOaoHXdpu0uZvYjseYOZIMAvwLG7Rqo2D566URe/ClmUdAr1n2suuu3v+IIlWb7nKlJlmkTYlPE8O3LLCXPJyQKypLzivCsZzjTcu6xiXKkgF6e0VqPlGOW8/zLphG8ehrQJduslg/EHG6vSPJBoTydqEQ+spHGUDjCVUMJXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=Jk6yobiL; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from darkstar.musicnaut.iki.fi (85-76-140-31-nat.elisa-mobile.fi [85.76.140.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V7lD70ZTfz49Py3
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 00:54:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712008487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=Mn8bJl3NFyQtwMBOkdGvS3lwI8lw3E5zb48HP4oCIPQ=;
	b=Jk6yobiLJDaRfz+oPSY9cbLK4KB2nW/3nepwl9RQuG4q4XDaDng5VcnBVjmwi1dQkNYeTM
	Pd5JGeXQv1yS1bcpLIthAdZcyPzqiqFbXJZ623IvPakTjtL89+t35pLMLMkqAoX/jYdGLz
	Rsl6Ynwc106+xF4D4YExRiHvkRbTq1FixaE+Ta3Rbs2KjpyH17AVLbsdEy5luYNfFdxMcF
	NN5Vik/9S0gug1FDL8tmNgm4eXk8JFNrefWcJ5k3c/P4uyupRMWC33eGqOqhIhyzvBpvJO
	k4LzoXlaA4e/EyJm97n8rPDlfWfGuig8jE4133e5HanubWStR7KkoFlAeZET6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712008487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=Mn8bJl3NFyQtwMBOkdGvS3lwI8lw3E5zb48HP4oCIPQ=;
	b=cyFzFXna2+Yx8WW/xnEaukoQwLq0ifmqOxEGsu/CeFpSfTZQYTeGIFMCocDONTA89vWek8
	OwdZ7kWJyR03p+zx6QYCdlbP3Y+JK/wlO/Aa4uhhMdQArw3wrFpkAN5YK9elryBEVKCixl
	vIbBFSXH/5PqNUydLNh8Ttp6t/XKoyFw1P3UVkDNmPTdae8vfEcZrQRQyeAq4HLLBpE7pq
	MfRV4EbPGkAztIomV6WtUcH/qCVJR7EasoyBYR1xJZj3pTSr237TFwN/ArHu3biJepZdnH
	iAfyUUu/eBenAknTNSAIptgq8P7BA3iBrgnARZ+MGOt/Sl99FN4XR7KchKvCYg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712008487; a=rsa-sha256;
	cv=none;
	b=RR9DHjzfkdgFyuLiVELV+xTEsRNDgoFamMuh2F1vTFlKKVfazXYaz/B0HuYpoFZi2ZKTgS
	Gz3NnyuOMadhvgmnC+fdLH6+bSEpdttj5tMYl8IRlbBrSCQpIbE5OPpn4yUf9FbjKNECUe
	tclgDL1h25+fphpjs0ymUJZdGNDy/DkiiVvRBffqr3XMJ/NLkUWVSO+h7s0YzbDjzAB+nQ
	+nhJCM92RGb3QMTycIxcGVjKrgQVumFod+z9EurbG3F20F/GbPsz+FfadOit1HdxKsSQY7
	F999u2i6F0NMexQt3R9LudtQ2180f5PD8GePPFQncWLcDY9OKVDV7yj10GjNmQ==
Date: Tue, 2 Apr 2024 00:54:45 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: stable@vger.kernel.org
Subject: Request to cherry-pick a patch for v5.15 (locking/rwsem: Disable
 preemption while trying for rwsem lock)
Message-ID: <20240401215445.GA91663@darkstar.musicnaut.iki.fi>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear stable team,

Would you please cherry-pick the following patch into v5.15 stable:

  locking/rwsem: Disable preemption while trying for rwsem lock

  commit 48dfb5d2560d36fb16c7d430c229d1604ea7d185

Earlier discussion:

  https://marc.info/?l=linux-kernel&m=170965048500766&w=2

Thank you,

A.

