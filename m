Return-Path: <stable+bounces-145877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311C3ABF959
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 17:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15864E0343
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 15:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3D21C701C;
	Wed, 21 May 2025 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cg7eyo8P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5C29461;
	Wed, 21 May 2025 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841536; cv=none; b=JgNOopwFdIv/ObiCmjbuZraeUm4VY8XibApeozH4ZUNk4D6UDrdEifb2+tKlT8Tu+fMTr4B9WfXOMYf3sY04V+noXE4ERtzStUUNUxcxj2zl2Lmts7nBsnRNQFpmqaaN0/uW31dROg3yhkjoVHLwDmIBd0Ga4Jz3TKlq5FyyuHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841536; c=relaxed/simple;
	bh=5SONIjkkgio0G9/2yq0GzFXr4VaBVp93e8fBGFTaexk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ew6QuMr9nTYXiLfRHJtFt90nA4XTfFXY8TRWtSXglndlMJGa+vlhTnxYmCfdcmWZnE/81gzGxbTZzfEyNtpHxpEIi9Og5Bx0gX3KFPuABCjn9hcbg1CP8zYdi27f+qYePInfbtSMPsuyLwusZEeEzZ0o9nNi5Lwxjr+OA3iHWQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cg7eyo8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C67C4CEE7;
	Wed, 21 May 2025 15:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747841536;
	bh=5SONIjkkgio0G9/2yq0GzFXr4VaBVp93e8fBGFTaexk=;
	h=From:To:Cc:Subject:Date:From;
	b=Cg7eyo8PnZKsoBP0lzMTcuAz/2qun2XeZqW2QmLPSmVvBeHcIm2lU3s9PYrvUktU4
	 +RXitnsVXvLkP0Dn1s9TAbscYnCPUSuWCbUsT//3BcRtvbsR/ul6hhsVm4Ak1LtDte
	 e0vVlbYRAoS90C4U4WvJvYY8kQv7zuZhCtZ+mv0hjuQ7xF8R0ds6ECwUPCBb346fQu
	 FX77bYryZAhHj08OqADQUAVR2n7QYD/DxsaEcVCCt9e3hfjYurdPiI+svipGe8Z0DH
	 qFdFsVuGelK3UuaVMOmwwYhXYWiQCwIIUJUrv9O4NFIkemdbWD9cTrJQmVrvqB7ZWH
	 M0J3qu6jSMm4w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	Rao Shoaib <Rao.Shoaib@oracle.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v6.1 00/27] af_unix: Align with upstream to avoid a potential UAF
Date: Wed, 21 May 2025 16:26:59 +0100
Message-ID: <20250521152920.1116756-1-lee@kernel.org>
X-Mailer: git-send-email 2.49.0.1143.g0be31eac6b-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the second attempt at achieving the same goal.  This time, the
submission avoids forking the current code base, ensuring it remains
easier to maintain over time.

The set has been tested using the SCM_RIGHTS test suite [1] using QEMU
and has been seen to successfully mitigate a UAF on on a top tier
handset.

RESULTS:

  TAP version 13
  1..20
  # Starting 20 tests from 5 test cases.
  #  RUN           scm_rights.dgram.self_ref ...
  #            OK  scm_rights.dgram.self_ref
  ok 1 scm_rights.dgram.self_ref
  #  RUN           scm_rights.dgram.triangle ...
  #            OK  scm_rights.dgram.triangle
  ok 2 scm_rights.dgram.triangle
  #  RUN           scm_rights.dgram.cross_edge ...
  #            OK  scm_rights.dgram.cross_edge
  ok 3 scm_rights.dgram.cross_edge
  #  RUN           scm_rights.dgram.backtrack_from_scc ...
  #            OK  scm_rights.dgram.backtrack_from_scc
  ok 4 scm_rights.dgram.backtrack_from_scc
  #  RUN           scm_rights.stream.self_ref ...
  #            OK  scm_rights.stream.self_ref
  ok 5 scm_rights.stream.self_ref
  #  RUN           scm_rights.stream.triangle ...
  #            OK  scm_rights.stream.triangle
  ok 6 scm_rights.stream.triangle
  #  RUN           scm_rights.stream.cross_edge ...
  #            OK  scm_rights.stream.cross_edge
  ok 7 scm_rights.stream.cross_edge
  #  RUN           scm_rights.stream.backtrack_from_scc ...
  #            OK  scm_rights.stream.backtrack_from_scc
  ok 8 scm_rights.stream.backtrack_from_scc
  #  RUN           scm_rights.stream_oob.self_ref ...
  #            OK  scm_rights.stream_oob.self_ref
  ok 9 scm_rights.stream_oob.self_ref
  #  RUN           scm_rights.stream_oob.triangle ...
  #            OK  scm_rights.stream_oob.triangle
  ok 10 scm_rights.stream_oob.triangle
  #  RUN           scm_rights.stream_oob.cross_edge ...
  #            OK  scm_rights.stream_oob.cross_edge
  ok 11 scm_rights.stream_oob.cross_edge
  #  RUN           scm_rights.stream_oob.backtrack_from_scc ...
  #            OK  scm_rights.stream_oob.backtrack_from_scc
  ok 12 scm_rights.stream_oob.backtrack_from_scc
  #  RUN           scm_rights.stream_listener.self_ref ...
  #            OK  scm_rights.stream_listener.self_ref
  ok 13 scm_rights.stream_listener.self_ref
  #  RUN           scm_rights.stream_listener.triangle ...
  #            OK  scm_rights.stream_listener.triangle
  ok 14 scm_rights.stream_listener.triangle
  #  RUN           scm_rights.stream_listener.cross_edge ...
  #            OK  scm_rights.stream_listener.cross_edge
  ok 15 scm_rights.stream_listener.cross_edge
  #  RUN           scm_rights.stream_listener.backtrack_from_scc ...
  #            OK  scm_rights.stream_listener.backtrack_from_scc
  ok 16 scm_rights.stream_listener.backtrack_from_scc
  #  RUN           scm_rights.stream_listener_oob.self_ref ...
  #            OK  scm_rights.stream_listener_oob.self_ref
  ok 17 scm_rights.stream_listener_oob.self_ref
  #  RUN           scm_rights.stream_listener_oob.triangle ...
  #            OK  scm_rights.stream_listener_oob.triangle
  ok 18 scm_rights.stream_listener_oob.triangle
  #  RUN           scm_rights.stream_listener_oob.cross_edge ...
  #            OK  scm_rights.stream_listener_oob.cross_edge
  ok 19 scm_rights.stream_listener_oob.cross_edge
  #  RUN           scm_rights.stream_listener_oob.backtrack_from_scc ...
  #            OK  scm_rights.stream_listener_oob.backtrack_from_scc
  ok 20 scm_rights.stream_listener_oob.backtrack_from_scc
  # PASSED: 20 / 20 tests passed.
  # Totals: pass:20 fail:0 xfail:0 xpass:0 skip:0 error:0

[0] https://lore.kernel.org/all/20250304030149.82265-1-kuniyu@amazon.com/
[1] https://lore.kernel.org/all/20240325202425.60930-16-kuniyu@amazon.com/

Alexander Mikhalitsyn (1):
  af_unix: Kconfig: make CONFIG_UNIX bool

Kuniyuki Iwashima (24):
  af_unix: Return struct unix_sock from unix_get_socket().
  af_unix: Run GC on only one CPU.
  af_unix: Try to run GC async.
  af_unix: Replace BUG_ON() with WARN_ON_ONCE().
  af_unix: Remove io_uring code for GC.
  af_unix: Remove CONFIG_UNIX_SCM.
  af_unix: Allocate struct unix_vertex for each inflight AF_UNIX fd.
  af_unix: Allocate struct unix_edge for each inflight AF_UNIX fd.
  af_unix: Link struct unix_edge when queuing skb.
  af_unix: Bulk update unix_tot_inflight/unix_inflight when queuing skb.
  af_unix: Iterate all vertices by DFS.
  af_unix: Detect Strongly Connected Components.
  af_unix: Save listener for embryo socket.
  af_unix: Fix up unix_edge.successor for embryo socket.
  af_unix: Save O(n) setup of Tarjan's algo.
  af_unix: Skip GC if no cycle exists.
  af_unix: Avoid Tarjan's algorithm if unnecessary.
  af_unix: Assign a unique index to SCC.
  af_unix: Detect dead SCC.
  af_unix: Replace garbage collection algorithm.
  af_unix: Remove lock dance in unix_peek_fds().
  af_unix: Try not to hold unix_gc_lock during accept().
  af_unix: Don't access successor in unix_del_edges() during GC.
  af_unix: Add dead flag to struct scm_fp_list.

Michal Luczaj (1):
  af_unix: Fix garbage collection of embryos carrying OOB with
    SCM_RIGHTS

Shigeru Yoshida (1):
  af_unix: Fix uninit-value in __unix_walk_scc()

 include/net/af_unix.h |  48 ++-
 include/net/scm.h     |  11 +
 net/Makefile          |   2 +-
 net/core/scm.c        |  17 ++
 net/unix/Kconfig      |  11 +-
 net/unix/Makefile     |   2 -
 net/unix/af_unix.c    | 120 +++++---
 net/unix/garbage.c    | 691 +++++++++++++++++++++++++++++-------------
 net/unix/scm.c        | 154 ----------
 net/unix/scm.h        |  10 -
 10 files changed, 618 insertions(+), 448 deletions(-)
 delete mode 100644 net/unix/scm.c
 delete mode 100644 net/unix/scm.h


-- 
2.49.0.1143.g0be31eac6b-goog


