Return-Path: <stable+bounces-233835-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODoYNGwz1mlZBwgAu9opvQ
	(envelope-from <stable+bounces-233835-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 12:52:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1A63BAF3F
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 12:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB1C13011150
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 10:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263A2398900;
	Wed,  8 Apr 2026 10:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvYL18z5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC43D3B9DA3
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 10:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775645531; cv=none; b=gvxNVMa4TR7bM6PKxBs0MgX1O7ljkxPlXO5c81sJNuYgrXtbLc/SwtthOAvnRoDIlTd2+HJeVcDxDAv9uI/ZMwBui/Vr+AsdONWl/eBq4zvOxePp4Tk1hRjC6nRGBUk4yGRdVB4TUHicU7BictsFnED9Qzn6xPyOn5QllpN4Z6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775645531; c=relaxed/simple;
	bh=L1FcjUcFcQuiEqj5VeZgWDHAhD2/oH4v8TV2Hc5Y2cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZ8IYDC3xb3CjHAB00T6XRDCKA+O2MFFVW11HZ1bf1AY/KAy9JpMfE0YMQI6RxjFOH9sTkRreCiDO4I9InJmNi3GmHvy553nIhYeDX+4F/wH1122e8ONOtIBl2La82fu/uSIEEIA/yosc6Qe/+n4Zv46XhtZ4yvF+z9MAdZfKbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvYL18z5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E92C19421;
	Wed,  8 Apr 2026 10:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775645531;
	bh=L1FcjUcFcQuiEqj5VeZgWDHAhD2/oH4v8TV2Hc5Y2cM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mvYL18z5r1qYT6SQ7LdaVLXBNiB6/gjL44TEWY5xmLcPPb1hDXowT1uzQHNc4/kz6
	 /RtOCC1c+z1w6HE9zFk0bR+qF/GzM6NE434m0ae557gMuafeT2EsiiFQWDtBGlMDVh
	 MzygUZiMAAvyXj/e3+cE17OL9glIlJMy61So+rGbhYoGfb3rPJV4yx+pnGI1lr2SQO
	 BM162JSKxju/aKKL2ek55+TDtvnBmyE/kFKrPhIUp83D0+3pQ1+g72ZzKIBVl5r3v3
	 BbwtTB1DWqXfEyAm5QdHH85U/WjMPDIHvLT9Xy1DP3BEyCcPp5Lcjde+77HZpw0QlD
	 cUtCaASP2lqxA==
From: Sasha Levin <sashal@kernel.org>
To: Xi Ruoyao <xry111@xry111.site>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.6.y] LoongArch: vDSO: Emit GNU_EH_FRAME correctly
Date: Wed,  8 Apr 2026 06:52:10 -0400
Message-ID: <20260408105210.946599-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331163417.118893-1-xry111@xry111.site>
References: <20260331163417.118893-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-233835-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D1A63BAF3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> With -fno-asynchronous-unwind-tables and --no-eh-frame-hdr (the default
> of the linker), the GNU_EH_FRAME segment (specified by vdso.lds.S) is
> empty.

Queued for 6.6, thanks.

