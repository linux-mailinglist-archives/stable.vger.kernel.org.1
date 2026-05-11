Return-Path: <stable+bounces-245186-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qg6fJGfNAWryjwEAu9opvQ
	(envelope-from <stable+bounces-245186-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:36:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 467B550DF93
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C892F30F33FF
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 12:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B013F65E1;
	Mon, 11 May 2026 12:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rm78s1Ub"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295473E122F
	for <stable@vger.kernel.org>; Mon, 11 May 2026 12:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778502408; cv=none; b=kUyGt0MdLxfgAnboKkQyv0Dh1sWWvU+zFRAkYfvQqS9W0RizM+bH1F2a5pZsZf/GHZgvpXksIhkd+2WWuAB2ZH+xrC8KljHyEQ0Hl5RnjaSYThSMryCt/YMih1hRBHYuvtrbi1Cu8HaxEvx7sqZwFadpVRMvJq8cJDbHrksKgdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778502408; c=relaxed/simple;
	bh=G0x9V/BI3+TkxKKe772RWr7WrNrThQ0LLlvnqrrrQKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lOkYwbj9o3a/Hd7rc01rcVONcXtqzEPoPRVTzmUvqPCnn+VZL5nnGEZtQzu/i89ClaG3fvouixxfEdrgAktVpzXPtzMnDLRi6Ajh6wLqe/lcNBae7RZDiQ5B4aUCI2LjFw2jK+/cB2x4P0Q3E6yNdTxuyqD7MoOIBw6GSRNkMBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rm78s1Ub; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8e0a768331cso538465685a.0
        for <stable@vger.kernel.org>; Mon, 11 May 2026 05:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778502405; x=1779107205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eApZdy9HouG7Tom5otuoq8d1bHH7NMiFlZKRNtB+9kk=;
        b=Rm78s1UbNcuOLAQ/jIxoezgrAKfhgUdoR8vH1kkpBSLhq1tm0SSmxurQ1vxmWvCQTF
         EFnblfkJTqUYCYg4AVND7aVdZzxRyrYTOECN77vnYtA49VxxccAkx+Gt/0LLgsLfuPgA
         pCAw0CxFASJcmzNRVfzxIyNlOeDKfrNDlR8EEpoc1JU3J1gjGhnsxodtTpFIJSCbbZei
         xN5+YguzFxOAcCJ/sv+jcrB3wJdo+ZDfRUjCcZbR3Z7s0eneAXw/ewLQE1SO9iCQklAe
         w03z6qSkG6Jj+m9ib5V12+m6LUtwsIe0YUhx3UGaiOVGRZse51aD5dsdYB0iHNOu4w1K
         EgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778502405; x=1779107205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eApZdy9HouG7Tom5otuoq8d1bHH7NMiFlZKRNtB+9kk=;
        b=rf6tHb0n55EIbeDJJYccrdb0ve/rFVb8WTnKH6dcl3OMOJB1gWKZrJFKPO2kIrvlqP
         63GG/xXO96d5uT89Vm3jnoSb9IwskPhMpliQA8ElB2M1ViW3kxfZOmL43sltT+pl35zS
         FAVT1ub82khZoTDCRwd6AcPrzmkQz/uW0MioNTFY3ofgHDNVlQX9ChkSMdfli2G7lUdQ
         gfAuVCsI2Krtdv3wi90IdaKm15sDVExoCCROQtALWQTTkpokcx1zJzPKLAhLzxBoW17U
         N9sgoSDe7+y3IqeYVEge/Mxp9hftDYz+Mla6/y1BM8grZjfjV6A/wTzKP/RFWUNaaAWE
         Y9cw==
X-Forwarded-Encrypted: i=1; AFNElJ8wjPdZTFA8FUfAxOOnBAMy/SdN9QiwODYANagHhIEkBt0xYTpURZglasrIpm4edkv+s34cKNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm4BdaRsJm180xA6hu1OGjOZ2SlfgTNjDlIg9ZgdERxWHjgz6+
	wD08DV2QkvL5GtCd8zQmGN1p4mv57ApNRJPsHkdZAtsyqvSlGJZYqY/K
X-Gm-Gg: Acq92OEK3oRG501fmlADEvz1dNejRK89DuFR+dIZhUOXH4PWl7Qu1AOPsj6UG3ZPfZ9
	rVUTE6jrhL0GvTJsRoKDCt+Saxu5P1TRmY6GycjPMS8HNw4R3U6GMI9+Sm9lrmBgrwaNGErAqnO
	pDaVxmg3OVfWy1mvTgFi0/0Tx/+JWW2f3vQ+VzySfzV7ADjGjHUQJkFJgR8Ibv4BUwrT9wWp+sQ
	V4gIqBieQzXz6fPI1ZdInCY1tlnJU6bV7cxj9F5MCzUU48bx02KYCOZKsEqonlTNdPu4SDtGv36
	6msVq/C3Ih6aRk0kW2vuRQq4iTnq5NItWrx+qloc48BN6CcB88KVqfgAuawZEPh2wONog3LuVZt
	9zwQqCdQYTxkFg6yU6M48ls+H66YQnMxgxHP4GBN5CGanpFawvZpBGeMSCEGqYnG0++R9T9epqo
	Dukr2c6i3ZWhjAL+TEvQrtrO3voHtnxeoIHdvw9ZiZvciHYwtB0SEmHMI+c33IPaBDLq6eQG0BH
	m/w6zykW9qywQAbZuQhz9a9UCxaiPxmk/Odau/3asY=
X-Received: by 2002:a05:622a:138b:b0:50f:340f:ff35 with SMTP id d75a77b69052e-51475c8ba3bmr220256631cf.26.1778502404796;
        Mon, 11 May 2026 05:26:44 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e7bf7e4sm88392871cf.17.2026.05.11.05.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 05:26:43 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: L2CAP: ecred_reconfigure: send packed pdu, not stack pointer
Date: Mon, 11 May 2026 08:26:41 -0400
Message-ID: <20260511122641.437434-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 467B550DF93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245186-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Commit 1c08108f3014 ("Bluetooth: L2CAP: Avoid -Wflex-array-member-not-at-end
warnings") converted the on-stack request PDU in l2cap_ecred_reconfigure()
from an explicit packed struct to DEFINE_RAW_FLEX(), but did not adjust the
size and source-pointer arguments to l2cap_send_cmd():

  -    struct {
  -            struct l2cap_ecred_reconf_req req;
  -            __le16 scid;
  -    } pdu;
  +    DEFINE_RAW_FLEX(struct l2cap_ecred_reconf_req, pdu, scid, 1);
       ...
       l2cap_send_cmd(conn, chan->ident, L2CAP_ECRED_RECONF_REQ,
                      sizeof(pdu), &pdu);

After the conversion, DEFINE_RAW_FLEX() expands to declare an anonymous
union pdu_u plus a local pointer "pdu" pointing at it. Therefore:

  - sizeof(pdu) is now sizeof(struct l2cap_ecred_reconf_req *) = 8 on
    64-bit (4 on 32-bit), not the 6 bytes of (mtu, mps, scid[1]).
  - &pdu is the address of the local pointer's stack storage, not the
    address of the request payload.

l2cap_send_cmd() forwards (data, count) to l2cap_build_cmd(), which calls
skb_put_data(skb, data, count). The L2CAP_ECRED_RECONFIGURE_REQ packet
body therefore contains 8 bytes copied from the kernel stack starting at
&pdu -- the 8 bytes overlap the pdu pointer's value, leaking a kernel
stack address to the paired Bluetooth peer. The intended (mtu, mps, scid)
fields are not transmitted at all, so the peer rejects the request as
malformed and the L2CAP_ECRED_RECONFIGURE feature itself has been broken
for the local-side initiator since the introducing commit landed.

The sibling site l2cap_ecred_conn_req() in the same commit was converted
correctly (sizeof(*pdu) + len, pdu); only this site was missed.

Restore the original semantics: pass the full flex-struct size via
struct_size(pdu, scid, 1) and the pdu pointer (the struct address) as
the source.

Validated on a stock 7.0-based host kernel via the real call path:
setsockopt(SOL_BLUETOOTH, BT_RCVMTU, ...) on a BT_CONNECTED
L2CAP_MODE_EXT_FLOWCTL socket emits an L2CAP_ECRED_RECONFIGURE_REQ
whose body is 8 bytes (the on-stack pdu local's value) rather than
the expected 6. Three captures from fresh socket / fresh hciemu peer
on the same host -- low bytes vary per call, high 0xffff confirms a
kernel virtual address (KASLR-randomised stack slot, not a fixed
string):

  RECONF_REQ body (ident=0x02 len=8): 42 fb 54 af 0e ca ff ff
  RECONF_REQ body (ident=0x02 len=8): 52 3d 2e af 0e ca ff ff
  RECONF_REQ body (ident=0x02 len=8): b2 fc 5b af 0e ca ff ff

After this patch the body is 6 bytes carrying the expected
little-endian (mtu, mps, scid).

Cc: stable@vger.kernel.org
Fixes: 1c08108f3014 ("Bluetooth: L2CAP: Avoid -Wflex-array-member-not-at-end warnings")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/bluetooth/l2cap_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 77dec104a9c3..4773a453b145 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7282,7 +7282,7 @@ static void l2cap_ecred_reconfigure(struct l2cap_chan *chan)
 	chan->ident = l2cap_get_ident(conn);
 
 	l2cap_send_cmd(conn, chan->ident, L2CAP_ECRED_RECONF_REQ,
-		       sizeof(pdu), &pdu);
+		       struct_size(pdu, scid, 1), pdu);
 }
 
 int l2cap_chan_reconfigure(struct l2cap_chan *chan, __u16 mtu)
-- 
2.53.0


