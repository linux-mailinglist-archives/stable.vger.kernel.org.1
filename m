Return-Path: <stable+bounces-222957-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLQyAGFwp2kEhgAAu9opvQ
	(envelope-from <stable+bounces-222957-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 00:36:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D9E1F868A
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 00:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 589AA30A573B
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 23:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB6C3563D7;
	Tue,  3 Mar 2026 23:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOYk0Z2l"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224EF35B65E
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 23:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772580940; cv=none; b=fto/NbbPYjxgx1fFD0oY/OyEU0FTWG6S69yDLe6pNVBa9D6IfbvNqCP+gg3NxAoUIf//3u9YMNwWRG/z2dV3OOqmL10mTx3brjzicTtGixLCXYG5U0uziKI3Qcv2ODIJ/cfRIuPt1NQ0Byshd3w+PgdUZIzWBhnm4t/wt/h8hbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772580940; c=relaxed/simple;
	bh=dCUHP9CgxLTwhE4ZO5/pmfP/TWGqsXqdgVyysbY1DjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rmtKs1anU7mrDkJ/6LRK+Tgth654PJgo/+PXLhzVZGXUf5MNj3wxTtPJ7Cwu9bq5SXwvXgRAsLTZE45SnM1LQsN2aMx46bg6ae2m9oau0dFtRjBwSax2Am7H9Yw939W3QMKwWnQgy0YdapDrgZVQASW5KYw14hzwI00AabNBhPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOYk0Z2l; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82735a41920so2411275b3a.2
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 15:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772580938; x=1773185738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DKbVmY+efMopyqBXD9I1gQXiaAK8vG67nYLTMzqm3vI=;
        b=UOYk0Z2ltgbYwdoHNyn1UDKz/r7Uw3B5bdoFmnyOFuZnQG0CtRk5a2xeDCxSAgXydr
         bCKBI3aaQKfsPvMNg9V6b7nJceoux1nJvYRjdvI2WI6bULtbGLoDxIvQagHsXHwdvYWW
         PYx7emUpgUjPoetOoP7O3xKMtT+d6eHLAacJ74LxjyC2VgYdhUmH1sVK54Dio4XKg6rm
         lAD+cZ/eBTdBAT6Gg60ss319+lGTMP59aB6qJ5bQ4AbX9Q70sNZXjL5LaJkcuyf+b97v
         M7sQylkmP00H8zknacufpwITKZwhsWyR8/H5cAPVrQ++vBbdJjBOFOR9xs8M9DkuJ5dK
         wI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772580938; x=1773185738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKbVmY+efMopyqBXD9I1gQXiaAK8vG67nYLTMzqm3vI=;
        b=qtYcni2FJuuDaFE08zQ1GdSNMkWuxN/A3Alao07l10myD1SX8UFzgLzSiz+yDEKsPb
         TlnZ1degwOuautJBUm2e79QZN6KFvE2mu1zaXgqcdjYpvU3nj7RXTqSrDfRzoMO8jg+z
         3G3/7VXAbLRAaZzH9AP/OYW0sq7v36IVq1DZccGBvmvjE/Y4WCMbRWhU+1eIbxkcpP9F
         KlqKfubgjPMeaQNMSvdGaf07Z8DhR1Ear4pKFOe6ViqFtCuafxFRDjPOAEjkXrh2p5Ji
         GHoxzxHUmQXLOSOwArsi76zyV1oNIYg2klSMv3kNDtSnCg7ReSXN7uEQywH/f6JAU9bD
         ebgA==
X-Forwarded-Encrypted: i=1; AJvYcCXjZRIfYa0glWcT0lZfG7Jo80g6b9IMWoI7lVM7Eyh7JaV57d/SuRDwk7RyEh2g31yGrZRoqbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcnXnl6oum02YeLh9W62F69mq+DVOt4bsLhxi2iuhnwONcYywy
	2M8ts1qUYWVhV/REZzqnc1DanQWRdeK83OFfTz+n+H9+5spC7oUHpwD4MAeMag==
X-Gm-Gg: ATEYQzxxgUPVSyw1U92sF2AHcHNCGjL/vtzsFywxqsijTyodgzzdbQCC4fnRzV32DIA
	Lngjudu1ZwHTlMxSP9rotQhq6nbmmqUU/rz31EZdl7bjJE1LTOnp1D4+9HLFY5EBPvJpvb0uodl
	W9OKEE7eKVFd6BjEMkBAyqpqjPzkLlmuCDmGZ1MoEzWmjKaoNiHVTPP5jccHEVB77Bx90cbfF7J
	jOb9OI7d138Vi7Gb55sLpk9g7x0CFJz86Q57pxRSpZKaP5ZwnuGg0im+YB+caYH0GqWBXT53xUF
	/dzwlxS85RnSChYULXrJwAakz2W/T5tx5v4DJcMSImkgExV/5gae8ardXt7qDKb+uCjJqtWK84N
	jKJJePGogu+jpa55032Lfwca0EF2e7M6mCncCOC5KU9lyx96xFIMMW47YNYsqb3YyUVi6EScsWR
	dHFywAeDK1aWYcyqV6SQ==
X-Received: by 2002:a05:6a00:e0a:b0:824:a8f2:7de7 with SMTP id d2e1a72fcca58-8274da219acmr15477490b3a.60.1772580938385;
        Tue, 03 Mar 2026 15:35:38 -0800 (PST)
Received: from localhost ([2a03:2880:ff:59::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff350asm16087111b3a.35.2026.03.03.15.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 15:35:38 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	hch@infradead.org,
	willy@infradead.org,
	wegao@suse.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/1] iomap: don't mark folio uptodate if read IO has bytes pending 
Date: Tue,  3 Mar 2026 15:34:19 -0800
Message-ID: <20260303233420.874231-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 57D9E1F868A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222957-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This is a fix for this scenario:

->read_folio() gets called on a folio size that is 16k while the file is 4k:
  a) ifs->read_bytes_pending gets initialized to 16k
  b) ->read_folio_range() is called for the 4k read
  c) the 4k read succeeds, ifs->read_bytes_pending is now 12k and the
0 to 4k range is marked uptodate
  d) the post-eof blocks are zeroed and marked uptodate in the call to
iomap_set_range_uptodate()
  e) iomap_set_range_uptodate() sees all the ranges are marked
uptodate and it marks the folio uptodate
  f) iomap_read_end() gets called to subtract the 12k from
ifs->read_bytes_pending. it too sees all the ranges are marked
uptodate and marks the folio uptodate using XOR
  g) the XOR call clears the uptodate flag on the folio

The same situation can occur if the last range read for the folio is done as
an inline read and all the previous ranges have already completed by the time
the inline read completes.

For more context, the full discussion can be found in [1]. There was a
discussion about alternative approaches in that thread, but they had more
complications.

There is another discussion in v1 [2] about consolidating the read paths.
Until that is resolved, this patch fixes the issue.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/CAJnrk1Z9za5w4FoJqTGx50zR2haHHaoot1KJViQyEHJQq4=34w@mail.gmail.com/#t
[2] https://lore.kernel.org/linux-fsdevel/20260219003911.344478-1-joannelkoong@gmail.com/T/#u

Changelog
---------
v1: https://lore.kernel.org/linux-fsdevel/20260219003911.344478-1-joannelkoong@gmail.com/T/#u
Changes made to v1:
* Add Darrick's reviewed-by, cc stable@, add link to discussion to commit
  message (Darrick)

Joanne Koong (1):
  iomap: don't mark folio uptodate if read IO has bytes pending

 fs/iomap/buffered-io.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

-- 
2.47.3


