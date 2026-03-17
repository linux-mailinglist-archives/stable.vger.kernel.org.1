Return-Path: <stable+bounces-226824-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNWUDtqVuWkJKwIAu9opvQ
	(envelope-from <stable+bounces-226824-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:56:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 834212B05F8
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 932E7300A10A
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1073624B3;
	Tue, 17 Mar 2026 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GN6qi/tR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2329736EAB9;
	Tue, 17 Mar 2026 17:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768351; cv=none; b=VmXZkkmJv/2cTo/4iMHiVKUVqK3Hh3glnis6FpZCWmoZdGeMBDEOwoT6J6AHvmQC2mqlGWuClGU2QVqn8++4nKtoQcIJvjwjcvVOd1T+VY5feJDAkeI3MCFYMvNTvvQEtBim1kRm0UpvJ/n4K81wpyuF/kBHzdQY+KqIuWPv3aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768351; c=relaxed/simple;
	bh=L7AADAtLgR2aagaODFqUuJaDozWjH37i9JbMiZm8iN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZUOZA2Nm/VXal7in2CIlp8a+p/fZD3o9AJpJ0oT6HT5qw87QwpZIRkQYIAXX+XKymyFXde7+pFBgKwLV9y6y+cvgCI0QxxVhAUAtm/oIJmRqip/y4boQDxU4Yaw6Os9zPSfaFR3+/lgyUcBaBzXoUQh0ifr45qnetEOOGfTOZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GN6qi/tR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA88C4CEF7;
	Tue, 17 Mar 2026 17:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768350;
	bh=L7AADAtLgR2aagaODFqUuJaDozWjH37i9JbMiZm8iN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GN6qi/tRmyQ1I1INaau3LA5oWCez208LEzNWrwG32sHgtJ9aGTFVhJcz8fOlyk4/o
	 H/+mMa5IBJNc8Vgn8GZyCUSGXmngbNaQHu3spMb/4AF1/kqlnrsm+siBpbNrlIwUgu
	 bdbJPpr0hFrfOqdOa4UieHd4D3khT+WegA06PscI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Boris Burkov <boris@bur.io>,
	Bart Van Assche <bvanassche@acm.org>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.18 290/333] btrfs: add missing RCU unlock in error path in try_release_subpage_extent_buffer()
Date: Tue, 17 Mar 2026 17:35:19 +0100
Message-ID: <20260317163010.147501379@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226824-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,acm.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,bur.io:email]
X-Rspamd-Queue-Id: 834212B05F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bvanassche@acm.org>

commit b2840e33127ce0eea880504b7f133e780f567a9b upstream.

Call rcu_read_lock() before exiting the loop in
try_release_subpage_extent_buffer() because there is a rcu_read_unlock()
call past the loop.

This has been detected by the Clang thread-safety analyzer.

Fixes: ad580dfa388f ("btrfs: fix subpage deadlock in try_release_subpage_extent_buffer()")
CC: stable@vger.kernel.org # 6.18+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/extent_io.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4478,6 +4478,7 @@ static int try_release_subpage_extent_bu
 		 */
 		if (!test_and_clear_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags)) {
 			spin_unlock(&eb->refs_lock);
+			rcu_read_lock();
 			break;
 		}
 



