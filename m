Return-Path: <stable+bounces-236714-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGYgI0oh3Wn5aAkAu9opvQ
	(envelope-from <stable+bounces-236714-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:00:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA493F07EB
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C497931C25B6
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472EC3093B2;
	Mon, 13 Apr 2026 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hu7yjsLw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B25B2E11B9;
	Mon, 13 Apr 2026 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097605; cv=none; b=moitU2udMk3lTaET2xDBpiot5CrOY6xQvUJusE2QVO4MezosMrKl/EpKEkfbYHg7o92KQB/c1hK2Q905DmCv1pCMt3AojyyrKtV3J0kJzW4mnTRPXVj0lp9RIFWI34jAaGYjxRiJ1rrRajLneBVFJID9dIn8HaIqD+TgM1l5I5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097605; c=relaxed/simple;
	bh=TcsE8hhxc1+MB+y4/JOW3LbvaEOIzxR4ACIwiEDgxCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AYvYqJx4wL4B8C9BeBbDEqMm+TC4fLf/aDPMfYYlfpLshyiEMivAT3UNtWo3WHShzMAVoK4YjDV3PKgWxy9uoR0FZ8czBCy2Lx8sI3moyhh7P15cJUDBbrPXgfVwv9z9z8q2gzjHnRnkwmxzkgywts/pkYnmBNQ4AHNY20Komyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hu7yjsLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C64C2BCAF;
	Mon, 13 Apr 2026 16:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097604;
	bh=TcsE8hhxc1+MB+y4/JOW3LbvaEOIzxR4ACIwiEDgxCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hu7yjsLwF9cF+HjqzJiDBCMzumhKEHOOn9I8QZpbPh2cBNf9kBF2ZOg7TRC9STaHM
	 xz54q4mADrITijphVxIyxOqYCZ4cgLSaKa0spGSv7wSWoyVKaM5VTwSLXMr/kkeaFe
	 WW84pZstf1xrP/X6okrTAPk2m3O+2Lkwua27/C48=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Lukas=20Johannes=20M=C3=B6ller?= <research@johannes-moeller.dev>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.15 202/570] Bluetooth: L2CAP: Validate L2CAP_INFO_RSP payload length before access
Date: Mon, 13 Apr 2026 17:55:33 +0200
Message-ID: <20260413155838.026379716@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236714-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,johannes-moeller.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0CA493F07EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Johannes Möller <research@johannes-moeller.dev>

commit dd815e6e3918dc75a49aaabac36e4f024d675101 upstream.

l2cap_information_rsp() checks that cmd_len covers the fixed
l2cap_info_rsp header (type + result, 4 bytes) but then reads
rsp->data without verifying that the payload is present:

 - L2CAP_IT_FEAT_MASK calls get_unaligned_le32(rsp->data), which reads
   4 bytes past the header (needs cmd_len >= 8).

 - L2CAP_IT_FIXED_CHAN reads rsp->data[0], 1 byte past the header
   (needs cmd_len >= 5).

A truncated L2CAP_INFO_RSP with result == L2CAP_IR_SUCCESS triggers an
out-of-bounds read of adjacent skb data.

Guard each data access with the required payload length check.  If the
payload is too short, skip the read and let the state machine complete
with safe defaults (feat_mask and remote_fixed_chan remain zero from
kzalloc), so the info timer cleanup and l2cap_conn_start() still run
and the connection is not stalled.

Fixes: 4e8402a3f884 ("[Bluetooth] Retrieve L2CAP features mask on connection setup")
Cc: stable@vger.kernel.org
Signed-off-by: Lukas Johannes Möller <research@johannes-moeller.dev>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/l2cap_core.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4837,7 +4837,8 @@ static inline int l2cap_information_rsp(
 
 	switch (type) {
 	case L2CAP_IT_FEAT_MASK:
-		conn->feat_mask = get_unaligned_le32(rsp->data);
+		if (cmd_len >= sizeof(*rsp) + sizeof(u32))
+			conn->feat_mask = get_unaligned_le32(rsp->data);
 
 		if (conn->feat_mask & L2CAP_FEAT_FIXED_CHAN) {
 			struct l2cap_info_req req;
@@ -4856,7 +4857,8 @@ static inline int l2cap_information_rsp(
 		break;
 
 	case L2CAP_IT_FIXED_CHAN:
-		conn->remote_fixed_chan = rsp->data[0];
+		if (cmd_len >= sizeof(*rsp) + sizeof(rsp->data[0]))
+			conn->remote_fixed_chan = rsp->data[0];
 		conn->info_state |= L2CAP_INFO_FEAT_MASK_REQ_DONE;
 		conn->info_ident = 0;
 



