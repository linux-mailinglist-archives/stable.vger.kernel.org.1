Return-Path: <stable+bounces-233331-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GUzMXtL0mmLVgcAu9opvQ
	(envelope-from <stable+bounces-233331-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 13:46:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B3E39E30C
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 13:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 611AE30078B3
	for <lists+stable@lfdr.de>; Sun,  5 Apr 2026 11:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B8825A655;
	Sun,  5 Apr 2026 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kramkow.ski header.i=@kramkow.ski header.b="ZLE8WoMo"
X-Original-To: stable@vger.kernel.org
Received: from erebus.slow.network (erebus.slow.network [109.74.205.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAA84C6C;
	Sun,  5 Apr 2026 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.74.205.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775389559; cv=none; b=XvgMXGvvG6W1JQMeNZE6sN5G5dIoPcpCaBAW/ahRtTqx6Y1Ua5Seq8jdwPmqa6LbPOeGyFLa29akWHtt4pIkB/0pZtOplFrI+/CT/6j6jCQTXErTFBKDTDmk1fdybIH3yYruwUVuTbxC0hApcHrtSQuX2B2dM7HYsaR5NgR/lYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775389559; c=relaxed/simple;
	bh=BHzu9bNhLGkBjluJBKqKGBvo2iD25BZvaum6bQlvmKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HvwhObA3Bi1P6U1Z7KRi271/eSHCx4xF7b/bo7zfkjjy7NDonnlLUGjvt8rmgnIfiW5hecSbg/YfYP/HFCzsJ2lQyfi3xcLjh+gj0ktL6cAH1752mcVB3UD68YravZemwBgWQ3lZ9Phw6B+XsweOuL8pNQMMIajgZKwU8+XHELc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kramkow.ski; spf=pass smtp.mailfrom=kramkow.ski; dkim=pass (2048-bit key) header.d=kramkow.ski header.i=@kramkow.ski header.b=ZLE8WoMo; arc=none smtp.client-ip=109.74.205.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kramkow.ski
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kramkow.ski
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20220506; bh=BHzu9bNhLGk
	BjluJBKqKGBvo2iD25BZvaum6bQlvmKI=; h=date:subject:cc:to:from;
	d=kramkow.ski; b=ZLE8WoMoTyefJPSgLbBPy7TQq3Z69J1gRCQXhZEH1e7z/oHqj+oep
	QdtSU40Pc8Sw+r0icBHiBsvspuFIW3zF+OAG509/BpOh1fc9OMxWBKTvCKY8kc4tD6FQbx
	0THjj1J7Cv3Th/SYPaFWV/3guAfezF8ZGSS4vGsEs6IeO3SIeGlmBsDsg247gRw/NSEZ74
	mvNbH8FSkn63PiRHBG644v9V7V3wGYeCUBzACX0213LJqVjLPUjX/akP5YMHWw9sSbxctJ
	dsqpabBRdKOqDShw6igKa6yYfTLNPWMEIJFEJR4/q6S5eXWISTO1Hv6GkABfyF+SWJ8thQ
	nXq4cb/qw==
Received: from localhost (flit-04-b2-v4wan-169180-cust382.vm32.cable.virginm.net [81.96.161.127])
	by erebus.slow.network (OpenSMTPD) with ESMTPSA id f86476cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 5 Apr 2026 11:45:44 +0000 (UTC)
From: Tomasz Kramkowski <tomasz@kramkow.ski>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Tomasz Kramkowski <tomasz@kramkow.ski>
Subject: [PATCH 6.6.y v2 0/2] Fix `fremovexattr` missing `fdput`
Date: Sun,  5 Apr 2026 12:45:03 +0100
Message-ID: <20260405114505.568530-1-tomasz@kramkow.ski>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kramkow.ski,quarantine];
	R_DKIM_ALLOW(-0.20)[kramkow.ski:s=20220506];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233331-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tomasz@kramkow.ski,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kramkow.ski:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kramkow.ski:dkim,kramkow.ski:mid]
X-Rspamd-Queue-Id: 97B3E39E30C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As discussed, a v2 which includes the revert from the previous version
[0] and a new attempt at backporiting the upstream change which doesn't
cause the regression introduced in the first attempt[1].

In total, this fixes the missing `fdput` in the `fremovexattr`
`copy_from_user` error path that the backport was intended for.

I tested both the error case and the happy case in qemu.

[0]: https://lore.kernel.org/stable/20260404112219.389495-1-tomasz@kramkow.ski/
[1]: https://lore.kernel.org/stable/tencent_72B5370E2D4C4AC319ED4F0DCB479CA4B406@qq.com/

Al Viro (1):
  xattr: switch to CLASS(fd)

Tomasz Kramkowski (1):
  Revert "xattr: switch to CLASS(fd)"

 fs/xattr.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

-- 
2.51.0


