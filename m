Return-Path: <stable+bounces-245235-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBcdC2npAWohmQEAu9opvQ
	(envelope-from <stable+bounces-245235-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:36:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 75617510460
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 46DCC307D632
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9468D3FF890;
	Mon, 11 May 2026 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PakDgmP4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DD93FE373;
	Mon, 11 May 2026 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778509325; cv=none; b=PwC6rryXqw3CXLCf9OQM+PDUqCJi3kLdMCgqMIPenKAYdHBP4UwJAas9CcdjUFrgXPgS+eVcQcLAg2q3lmiO0ELnNCC3Ti+D4wKUxzikBALEsnn5K3EElFJHs1BaS4Q9rkyyhrUj0yHd/TWG46TCW7qK7uWPNWEfckHgnCAv2Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778509325; c=relaxed/simple;
	bh=Z2QF48gdVvyOL9rNcFPicbh7ho+W1iz3GfczmclZFIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwEx5t1ZXuR7U+kFIZbr3NumSFt0s6moSeGy/c09wgTe7VOyjHJzn0ZKtMGkNr6MenGQ8zaB54GpHsoLzCTbvFQeYg2xUH4uP2Qrt3CzJWufdNGjcg+5jhSb2UhCdjXKt3xFronBZmdxNU4qvCiZr40jmJC3pcb1dVv/QENRICI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PakDgmP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99841C2BCF7;
	Mon, 11 May 2026 14:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778509325;
	bh=Z2QF48gdVvyOL9rNcFPicbh7ho+W1iz3GfczmclZFIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PakDgmP4NSB6VJmyqEaD7BsYBeDqJ3bAAPZzz/TxT+bjNqTI/1yUZ8XHk2K0y33Ov
	 WoTrdEu8PjjMHlru+x9BzuwCSr+SOgKoxn9JccKwVCdid8pleqtW1XtJLHsDurg2iC
	 2ofw7Dk7Xl2ugensgMLcRWd4XJJxJbymG3Y2q7XKMhsCNAj802IXZsuAT2/sEWaDx0
	 Xk73pYcfbAvR7jMcqDlk6yxN4RsICCuzBE+N/AMMkr7Rg/lVVbt5gd6UcQ+Himhaen
	 sttxyN7Ley+3orroeAMP5mVuCz6E7DO5Ppoqh2hUN151Hj4GSg7OgGWQOY62acw/Cq
	 6osu9WjEZUgEQ==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	luiz.von.dentz@intel.com
Cc: Sasha Levin <sashal@kernel.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	Fang Wang <32840572@qq.com>
Subject: Re: [PATCH 6.1.y 1/2] Bluetooth: hci_sync: Remove remaining dependencies of hci_request
Date: Mon, 11 May 2026 10:21:54 -0400
Message-ID: <20260511141441.stable-reply-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <tencent_CA96C7486F1CF8F0C72A2274E56AD1766708@qq.com>
References: <tencent_CA96C7486F1CF8F0C72A2274E56AD1766708@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 75617510460
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-245235-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,vger.kernel.org,holtmann.org,gmail.com,davemloft.net,google.com,redhat.com,qq.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 02:34:05PM +0800, Fang Wang wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> [ Upstream commit f2d89775358606c7ab6b6b6c4a02fe1e8cd270b1 ]
>
> This removes the dependencies of hci_req_init and hci_request_cancel_all
> from hci_sync.c.

Queued for 6.1 as the prerequisite for 2/2 (the btintel hci_req_sync_lock
fix), thanks.

Note: this commit is pure refactoring upstream and would not normally be
a stable candidate on its own; we're taking it here only to make
hci_req_sync_lock visible from drivers/bluetooth/btintel.c in 6.1.y so
that 2/2 builds. A Stable-dep-of: 94d8e6fe5d08 trailer would have been
the conventional way to document that on the backport (see commit
8d83194e8a880 on 6.6.y for an example). I won't block on it for this
submission, but please add such a trailer if you submit similar
prerequisite refactors in the future.

--
Sasha

