Return-Path: <stable+bounces-218174-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNbmG5NRnmmbUgQAu9opvQ
	(envelope-from <stable+bounces-218174-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:34:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EF818F02D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5258B31553AF
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5BB24A06D;
	Wed, 25 Feb 2026 01:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gSsxXzbo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33D54369A;
	Wed, 25 Feb 2026 01:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982959; cv=none; b=IDGFYIIbbUHhTC4XX0LbMBJLCxw9h5k9avUKzOKsI3iWiATJxCYb2ggCgSKuFRq/6WbW2EU+C5BOffrA3HErm6vyEc4be1lzdVzILTcl9RtDyo9iPEM+Qq1sdYFTj7lCaMtboux2NOxL6DLpo+zQKpd38K6jR6GpB+A2BPckqmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982959; c=relaxed/simple;
	bh=StJYLfUb9eb59OCXpzrUAHlvD2EfCjgiyBV+u68gOhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=By38X/z6bfiAIGc887fmo2D0Jjvv/+zu84ty+AwT+kdeGOGd5Q6fy1crKbOlweSODVf7jMpc4tsa1AkdfqMm9Ddr+bqouwbYKF+7Lg/H9dnaO3Iqdq9upH3x2YFri4YGUKqziqy1OrK+vIOTkml5xfrV1AtxWwgYbHD0C/lwYTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gSsxXzbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A67C19423;
	Wed, 25 Feb 2026 01:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982959;
	bh=StJYLfUb9eb59OCXpzrUAHlvD2EfCjgiyBV+u68gOhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gSsxXzbosXTgkE9/duD2lksUH/7Y3QO2D2GA7Xoer4wGuUyokMVn5eiY8vUocCIPO
	 XsvksSRGfjythyM3kAXQeq3Rns0SYLC1JJcLV6NSxSuWBY/ynkYP+dqKDe+b+xr4dm
	 nUJ7I3F6m+4PgRYvrM8QaKplVdO8Py56f+RH6kjA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 136/781] selftests/xsk: properly handle batch ending in the middle of a packet
Date: Tue, 24 Feb 2026 17:14:05 -0800
Message-ID: <20260225012403.006117301@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218174-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: F2EF818F02D
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Larysa Zaremba <larysa.zaremba@intel.com>

[ Upstream commit 42e41b2a0afa04ca49ee2725aadf90ccb058ed28 ]

Referenced commit reduced the scope of the variable pkt, so now it has to
be reinitialized via pkt_stream_get_next_rx_pkt(), which also increments
some counters. When the packet is interrupted by the batch ending, pkt
stream therefore proceeds to the next packet, while xsk ring still contains
the previous one, this results in a pkt_nb mismatch.

Decrement the affected counters when packet is interrupted.

Fixes: 8913e653e9b8 ("selftests/xsk: Iterate over all the sockets in the receive pkts function")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Link: https://lore.kernel.org/r/20260203155103.2305816-2-larysa.zaremba@intel.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/test_xsk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 5af28f359cfda..69a5a9a5189b0 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -1090,6 +1090,8 @@ static int __receive_pkts(struct test_spec *test, struct xsk_socket_info *xsk)
 			xsk_ring_prod__cancel(&umem->fq, nb_frags);
 		}
 		frags_processed -= nb_frags;
+		pkt_stream_cancel(pkt_stream);
+		pkts_sent--;
 	}
 
 	if (ifobj->use_fill_ring)
-- 
2.51.0




