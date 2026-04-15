Return-Path: <stable+bounces-238136-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA2OFWCZ32nXWQAAu9opvQ
	(envelope-from <stable+bounces-238136-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 15:57:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1092340511C
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 15:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78587308FFF4
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 13:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A103BD237;
	Wed, 15 Apr 2026 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHB115gu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D59D3CF670
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776261441; cv=none; b=EZ9500oIPgvpj7z3YhvzQKn0a7x4gljo8U8A/NS9vwSv5rNwkhxLbt03F66pFdTWqyMTPlZXTU4l0rS7qkW1Zf5Mi7abyV1Q5LyABOEuL0tL00QP7GnYTZYZc4mD7K4WCuYEJ7TDJ5J7voTPIOigQysna4eV08ZtLsKlqzy5dWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776261441; c=relaxed/simple;
	bh=f0IlsYpWCatrQhtpyh6uzvCCVjtYvNCwB2kCDJxEUd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eACQsrqRbqmSlLLwHF0Obr+l3Xtfdy+hfxftZhomwPS/FTSWMbYYYY7wqN91HpMBeQk3RhD2lW0AefBRKMm+Bdz7PP6NNzZXoKKi08g2zEYk/ylbK9Gh/K/xXLsYhirqLn597Xd4dewfmX532ryW+XW+WElNfOdggecLlnys9cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHB115gu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE5AC19424;
	Wed, 15 Apr 2026 13:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776261440;
	bh=f0IlsYpWCatrQhtpyh6uzvCCVjtYvNCwB2kCDJxEUd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CHB115gu/mWzI2skI/TfkEJQQMG9frEXBfis0dcAEeAaZLUsWVpx0/HZ1YjKDb4ux
	 IbnH0IQwAf5wtfE9faplsKJaHHL2T9Xbl9FVPfFAhr5QaTcsWhHsQJzUvmS2aGdAxH
	 o0zqHajv/KFScQJ/pgQMysEbl+X+dNfeHzi1vZZTVJFDl1tGNesmumehJzoNCC/xlx
	 LF/fj4Xyaoz5y1nykj5gp+LVSw+t9NfgdKdR4Gu6U1xiJHQVFs3lxz61VbLj+MuzbW
	 C/HQjahIME5hvjfCbVo8S8YRwx9EoHvO826s1Aqhz3fBVxXMinAFDCae7GKJXOcctN
	 wXMIkF9ihvz5A==
From: Sasha Levin <sashal@kernel.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 5.10 199/491] wifi: cfg80211: cancel pmsr_free_wk in cfg80211_pmsr_wdev_down
Date: Wed, 15 Apr 2026 09:57:18 -0400
Message-ID: <20260415160000.cfg80211-pmsr-drop@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <db073c5606570f9dc898275785583a7d32031294.camel@decadent.org.uk>
References: <20260413155819.042779211@linuxfoundation.org> <20260413155826.522907380@linuxfoundation.org> <db073c5606570f9dc898275785583a7d32031294.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238136-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1092340511C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> But cfg80211_pmsr_wdev_down() holds the wiphy lock which the work item
> also tries to acquire.  Cancelling it synchronously can then lead to
> deadlock.

Dropped from the 5.15 and 5.10 queues, thanks.

