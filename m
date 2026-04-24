Return-Path: <stable+bounces-240883-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNPVKEdz62nCMwAAu9opvQ
	(envelope-from <stable+bounces-240883-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:42:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B2245F6F6
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E6B43024181
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56323D5643;
	Fri, 24 Apr 2026 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lkx9t/Qi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90093B38AE;
	Fri, 24 Apr 2026 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038086; cv=none; b=AZMsrGU5JFFUiRd9YBtfwRSrLpZ/zorAnBxsFb339CJlnHzoaJUsSySbN23QoQbYXIaZYPtKEXWR8cTGvRrdI21Ub57exOqnhB4JmQaws+UTFrbExGmuU27+cwYWY9a1i0imqqgi65iMSGl71p/ypuzPirD9+w8qX9AbQYnZINA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038086; c=relaxed/simple;
	bh=hX3NMacI9kyK/lGeKYGQNgX778/wkoUZ1pkWma5747E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ierjzzHSBbgnE96upHxHhx8fD5lQzaXyMjosnD41oQ+LQPHH/tHtij8BUKi9/Ir95nHHd2IvVz/GgkSTmqGahoUHsAngBB8HzF9NzLOddLMU+C7uu4nDYIIunElG9l64wlf+oHL2LKRjNkr8ZgZm8dJx1ChDEonxoGZjYTHGdD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lkx9t/Qi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF42C19425;
	Fri, 24 Apr 2026 13:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777038086;
	bh=hX3NMacI9kyK/lGeKYGQNgX778/wkoUZ1pkWma5747E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lkx9t/QiEyCoU+sRWf2tlYdVkQm1B2Z8LQfygGYmsCNBJ/8fP5E8WLtKPK4BDc1VA
	 0nBdpq+DeC0h7WvAn5hubScH3MjpmHJXR6KGTttxzmoYqEQPnMwo3kf1kQxdK3Y8IM
	 he5Rg0PdqVChlAbTnRxbqP7mfFnNy5ospgOdlBPw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"linux-crypto@vger.kernel.org, kunit-dev@googlegroups.com, Eric Biggers" <ebiggers@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 6.18 19/55] lib/crc: tests: Add a .kunitconfig file
Date: Fri, 24 Apr 2026 15:30:58 +0200
Message-ID: <20260424132434.090213400@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132430.006424517@linuxfoundation.org>
References: <20260424132430.006424517@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 10B2245F6F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240883-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kunit.py:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@kernel.org>

commit c13cee2fc7f137dd25ed50c63eddcc578624f204 upstream.

Add a .kunitconfig file to the lib/crc/ directory so that the CRC
library tests can be run more easily using kunit.py.  Example with UML:

    tools/testing/kunit/kunit.py run --kunitconfig=lib/crc

Example with QEMU:

    tools/testing/kunit/kunit.py run --kunitconfig=lib/crc --arch=arm64 --make_options LLVM=1

Link: https://lore.kernel.org/r/20260306033557.250499-4-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/crc/.kunitconfig |    3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 lib/crc/.kunitconfig

--- /dev/null
+++ b/lib/crc/.kunitconfig
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=y
+CONFIG_CRC_ENABLE_ALL_FOR_KUNIT=y
+CONFIG_CRC_KUNIT_TEST=y



