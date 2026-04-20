Return-Path: <stable+bounces-238878-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKVxOOIs5mliswEAu9opvQ
	(envelope-from <stable+bounces-238878-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:40:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC8142C221
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E71CE30AFC44
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F173ACA5E;
	Mon, 20 Apr 2026 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXsOwA3N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376233ACA59;
	Mon, 20 Apr 2026 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691291; cv=none; b=Qnk44twFBoiJELdZoxo/5TvCzvd1iLNlGTC8WLYOWTi6Ygdfi+wlqNGa2wcvob77joZtXaPwh+UpJNYOnjFA13nOm+zxVNr4Q3cvGndVeeC2kRw4sL4gvdcvMOh/dXRsiVzOdg5vHzexqIXroTlL6b/HVcgIdwjHUwUUOnB8RY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691291; c=relaxed/simple;
	bh=8LZ5bl+knt2OcJdfZuerLEqSkIkxSxyCfsrCyXvC3pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D762nLzCGXtcgEX5U/cXScp1NhrcTInItfpgzlK2aPjOmkrqgb481AZHGgXU9ugMpwgZ2cvm8GKk1Wo7kdiSWtmwnKiwA3kRbmccRoPNdcFo7tdR6mWJqYf1E2CRVKU/uLchJ8WxoCifFHGX7y64IIZjd2xeDIZM6G6Xt9EETy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXsOwA3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB0AC2BCB4;
	Mon, 20 Apr 2026 13:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691291;
	bh=8LZ5bl+knt2OcJdfZuerLEqSkIkxSxyCfsrCyXvC3pA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aXsOwA3NsQoFLxp3cwR66vcfiwp3mEf434XF1fa+C0zBVTX6nwVfD0qDcrAU/mjxU
	 wJl+V8qlgG4EfIeacSWZ4AQcyvQunffTp9rgBw1tomm2NHEYEOk7sXRz+Z1RPA4za6
	 mMlvy+i1ljSw5vXZnEBaAorgSblRxXJzlRmE8/tMTSJfmRMntwjcHba2PW2o87dOWO
	 GwOJaugc98LmUb8ZZN4JE2wtPS7SEQ6fkeOiuZT/OxWQZUuAKtQpG7PhUiSEC/EiAg
	 fcQw6I19y2z4GqZ4BZ8LGbPMrsn/0h7hOPhK3LXqd+/27QW1Rgnlw/w2RGSdOr+IHd
	 IsrWwc1IvDQtg==
From: Sasha Levin <sashal@kernel.org>
To: Robert Garcia <rob_garcia@163.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	Steve French <smfrench@gmail.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: Re: [PATCH 5.15.y] smb: client: fix potential UAF in smb2_is_valid_oplock_break()
Date: Mon, 20 Apr 2026 09:21:12 -0400
Message-ID: <20260420-stable-reply-smb-oplock-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417063426.1101332-1-rob_garcia@163.com>
References: <20260417063426.1101332-1-rob_garcia@163.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-238878-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,manguebit.org];
	FREEMAIL_TO(0.00)[163.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8DC8142C221
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026, Robert Garcia wrote:
> Backport of 22863485a462 ("smb: client: fix potential UAF in
> smb2_is_valid_oplock_break()") to 5.15.y.

Queued for 5.15, thanks.

--
Thanks,
Sasha

