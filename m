Return-Path: <stable+bounces-256624-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHqyJiGKGWoJxggAu9opvQ
	(envelope-from <stable+bounces-256624-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:44:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B31602625
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C37EF301D4E8
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D823E169E;
	Fri, 29 May 2026 12:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRWFsgkF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBA43E1225;
	Fri, 29 May 2026 12:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780058652; cv=none; b=QN6PohdUglN1/jtrsGkbYf+NhrnjiS0a+kGCnLbCaRq/Ug3zU9DPGMaLhTI+W99NTpMi3FkMtdr3w20vpfxYY7VzOX2q6rAxc/uZ8U4jLATa8REf4QcWe9eNpEINpazpfXVkCRFm05Y78tRrxNaHVL8hy+KAyTqLsJZl1/sKKU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780058652; c=relaxed/simple;
	bh=4gAXYJiwPeq/SNk677kWjgOzGdtIa1uR6yntyWWCVBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOT12etMZxUXrC/KGkGrjfTmzq+SRshqanUZOLoHg1xgyKrOLikkYZDCCvMPpa9KLGKRJhhh4gpyc4V1t4vEQgCnyfi+iddxsnZGwn8JV5mL7GkeJu27E61A8QuSxup+LWcQFvHGD6w+AzZdo37n0M0WYSl8NASAkS6GaBiSY3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRWFsgkF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EFA1F00893;
	Fri, 29 May 2026 12:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780058651;
	bh=4gAXYJiwPeq/SNk677kWjgOzGdtIa1uR6yntyWWCVBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IRWFsgkFqJhR1oyQybAAr6ZeR4t/bu71idc17uBdn4c8ipimROLtAbdXSsjoxBZV1
	 8/WVUTR0lqgMLrNgo7JEFXtBtxPsvVZGT3VonXAB7+f7pVARMTtDZw5neuIO0tt4kb
	 teto0tflV1uOm0NqaSVhRlAe2xTRm3WfkyYRGpel7lXiBZqRxKoXxA9kNt1F3dqbzF
	 CwlTVIOFyw7MZ5M2op1wpZjrSWTZ4y4xNFNC4QA4JppJHX51b1iQDh6MHN0bOZpoCe
	 fL4Re3VTa5uQpXYUUG22eMgXLusAMSOaGV7MlOQmjrSkTChweTY+0dw3/EQ7LYZIwZ
	 DJdm4/dkNkNew==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	bird@lzu.edu.cn,
	kuba@kernel.org,
	kuniyu@google.com,
	n05ec@lzu.edu.cn,
	patches@lists.linux.dev,
	stable@kernel.org,
	stable@vger.kernel.org,
	tomapufckgml@gmail.com,
	wangjiexun2025@gmail.com,
	yifanwucs@gmail.com,
	yuantan098@gmail.com,
	Wentao Guan <guanwentao@uniontech.com>
Subject: Re: [PATCH 6.6 229/474] af_unix: Reject SIOCATMARK on non-stream sockets
Date: Fri, 29 May 2026 08:44:03 -0400
Message-ID: <20260529120000.afunix-rc-drop@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527094544.2344825-1-guanwentao@uniontech.com>
References: <20260515154719.961677988@linuxfoundation.org> <20260527094544.2344825-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256624-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,lzu.edu.cn,google.com,lists.linux.dev,vger.kernel.org,gmail.com,uniontech.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 36B31602625
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 05:45:44PM +0800, Wentao Guan wrote:
> [DIFFERENT]:
> original patch patched in unix_ioctl(),
> this patch in 6.6 patched in unix_stream_read_generic().

Thanks, good catch.

--
Thanks,
Sasha

