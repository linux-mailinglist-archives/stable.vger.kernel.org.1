Return-Path: <stable+bounces-235630-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJXvNrAX2Wm7lwgAu9opvQ
	(envelope-from <stable+bounces-235630-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 17:30:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D133D953B
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 17:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5038F3115F20
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 15:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B233DEAE6;
	Fri, 10 Apr 2026 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="LyUOJVZs"
X-Original-To: stable@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2D63DE437
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834344; cv=none; b=Q7R6dYjoimvJBim6ytS7XI7OYCOF/3OZMCpTpysPk6jKnbXc7U6/dODeQmzygaOQsdXpm0QSYVB4HN9iHa6S7x+QgE+0FPGbqL/jMB1E0gZBImd7/d9p+JCo99faviC0/q1OHLX1i1wogrP6zvKu/EhdeM5TFHhLF13pztFR19I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834344; c=relaxed/simple;
	bh=RxpvA3eh9SHzgt4/2lh3Inm/8L4wRVYBA0eII59VMSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rK8VkPLqkRi975MkvMAOaL/69XJ2baGa/Zw8u7xgb8368mUASiRC3mEikj7sMxCAHxk6HdGV8j7A3va8GRf61p6jLX9z7jVdeUK4/fzKXVDiU3CALhd/qfHcNX+2vQEm4tkHoDoc4M6BqZE2eeTpUf5TShHUBzepiV/1VVVeEtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=LyUOJVZs; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-116-90.bstnma.fios.verizon.net [173.48.116.90])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 63AFImgN015769
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Apr 2026 11:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1775834330; bh=OY6G15C9EgyOfaVMAdim+tczgIT2XZ6nQM0Fntgveyc=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=LyUOJVZs8BaMuQinHijvZ1RHGXBxgfwVz47W7x4TAX820fc8LmDtCGXwjNrEDvOPT
	 aH6gJJbBgO2dee8/VC23R4CaVt1E8xjO3w3BZckVlokpqHmCEub5/soycXjKnoZUyw
	 nOFNSxGsQsPcVZNOT/Lald5fw9VQ+2o4N0OI6hiOYTOcop4Y8hzuWrU+ZvW26s4FbJ
	 hZou7VzIDgsrvFI9AtMYKKMpnoTLmdV34yW1YN03T7BhwBNearJhgE20RmnQLhQ55m
	 o6kgd2YecXWlc/hzbtcQ4iDw/uw+h4Y34LGmFD8Iqt5tt6aU5b+Tzdan3b74b/hg/l
	 d6fLmdggHQu4Q==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id EED782E00DB; Fri, 10 Apr 2026 11:18:47 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: adilger.kernel@dilger.ca, Deepanshu Kartikey <kartikey406@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        syzbot+fb32afec111a7d61b939@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] ext4: fix bounds check in check_xattrs() to prevent out-of-bounds access
Date: Fri, 10 Apr 2026 11:18:34 -0400
Message-ID: <177583430878.2758959.10038208065851589867.b4-ty@b4>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260328150038.349497-1-kartikey406@gmail.com>
References: <20260328150038.349497-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235630-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[dilger.ca,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[mit.edu:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,fb32afec111a7d61b939];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39D133D953B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Sat, 28 Mar 2026 20:30:38 +0530, Deepanshu Kartikey wrote:
> The bounds check for the next xattr entry in check_xattrs() uses
> (void *)next >= end, which allows next to point within sizeof(u32)
> bytes of end. On the next loop iteration, IS_LAST_ENTRY() reads 4
> bytes via *(__u32 *)(entry), which can overrun the valid xattr region.
> 
> For example, if next lands at end - 1, the check passes since
> next < end, but IS_LAST_ENTRY() reads 4 bytes starting at end - 1,
> accessing 3 bytes beyond the valid region.
> 
> [...]

Applied, thanks!

[1/1] ext4: fix bounds check in check_xattrs() to prevent out-of-bounds access
      commit: eceafc31ea7b42c984ece10d79d505c0bb6615d5

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

