Return-Path: <stable+bounces-238881-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJ8IKfs05mmOtQEAu9opvQ
	(envelope-from <stable+bounces-238881-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:15:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA5C42CCF9
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE4963201FD4
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B3E3ACEE2;
	Mon, 20 Apr 2026 13:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDY+ARWH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD96B3ACA7A;
	Mon, 20 Apr 2026 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691293; cv=none; b=loSGCVF/4OlQx8eUfyhbT740OfTMYqrkVFJOqTo22n6k9eDMaRklnf2FAkHB94b9FapZURze+G9xZlbK1l5Ddybb0kR7Jqljurd6nyQZI8gOHgh7K5g0MrijqUBILRKC0w3cJ66p4S9K8E5LyVarxiDXRcFDXgY28Z/06OW5W+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691293; c=relaxed/simple;
	bh=8IuLowldQlM5vyWZuim0L4vboYvqDtLOcLj9YZir9p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nREaCL/Z3naM6MDzBGea+i40e8jcxrp3OmIT/X75V4gPxNplApcFAXVQyxiOM+vWIhoNLbsUJiVhPR5VwtZuIWzs7lGaTFvuJSnkJYPJiSn6TEG5CRcmkyFxKZ/1i2zMIVkPD1pFN6pwobTQSGlu+lOtLgl4s0mAG8fnPGQEBUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDY+ARWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1ECC2BCB8;
	Mon, 20 Apr 2026 13:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691293;
	bh=8IuLowldQlM5vyWZuim0L4vboYvqDtLOcLj9YZir9p0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aDY+ARWH1AAOTewzlMTOCw8oR3nNf6Y0BU8tpzfAckxv8UXMXT51gJf9cOJ4baJEW
	 VIIGei11nEIKd9hQNiom5ePem7feNRd3nyuUcqcq9zx5CEAv+w2ahWmKkf/s/1Os7R
	 afs/BS9PHcOHzMNwKKByNVvhCTdaDL+4W+AvccM4v4c/N9qFrd7yuhxcX/DZ3/7f96
	 eN8UCjh7J7UGnmRQA3vL9ctid3bZ7mKqH/CT23hWzNtGKVYQ3wX5VnmlQif9HheocF
	 ASclRseiBg391luF4YQ/8NftLJ/C09Q3DgavDBeQW8hBFYykgYIZrivn8R70ZClD9E
	 esxo73A+u4zcQ==
From: Sasha Levin <sashal@kernel.org>
To: Rajani Kantha <681739313@139.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [PATCH 6.6.y] ice: Fix memory leak in ice_set_ringparam()
Date: Mon, 20 Apr 2026 09:21:15 -0400
Message-ID: <20260420-stable-reply-ice-ringparam-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417091753.4175-1-681739313@139.com>
References: <20260417091753.4175-1-681739313@139.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238881-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6CA5C42CCF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026, Rajani Kantha wrote:
> Backport of fe868b499d16 ("ice: Fix memory leak in
> ice_set_ringparam()") to 6.6.y.

Queued for 6.6, thanks.

--
Thanks,
Sasha

