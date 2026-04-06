Return-Path: <stable+bounces-233355-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBCcL0Fo02kCiAcAu9opvQ
	(envelope-from <stable+bounces-233355-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 10:01:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 485143A21D8
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 10:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD0D8300C24C
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 08:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C2814AD20;
	Mon,  6 Apr 2026 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RXBKmOP0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9805DF59;
	Mon,  6 Apr 2026 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775462460; cv=none; b=Ik5DCysA+aGLMgkdDzBJcASbGLFqFBfx2pKRsIuIUyK6+42m7tDiTVigHzTOuouOadjsx+cySXGwtskqf+uTdxGTiFesglXiuUg/NP2kK7+t3ikap8p9PByn0mJhLl5y1w3bHFznDduK62oUKQY0s+D20hq2w965ieGA86N2Qak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775462460; c=relaxed/simple;
	bh=vIn9hCLh+bcVhJF58FigP4h2Nx6xwDYTfoluQ2C1Bpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f2KAoIsdWUZhwpjb6l6THJRh4oHs9WfCQb0fe7wOKyouUWfHs4O5IHFAMdaM5QNtdeeql/QJrbCK9Ui5ixHr/oSMN6brc5U4FTVGvGPcQlXyg1FV6VlkgpeKNIJTD0jsmXl2Kh6bPutgIePJ1G7lWLGCcJR5ty3kr6Z2VmEghBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RXBKmOP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB62FC4CEF7;
	Mon,  6 Apr 2026 08:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775462460;
	bh=vIn9hCLh+bcVhJF58FigP4h2Nx6xwDYTfoluQ2C1Bpw=;
	h=From:To:Cc:Subject:Date:From;
	b=RXBKmOP0AXKCpeUTPTBpmmFFW+anAKG4dQ+8Q6ssUlNHawfVeRadwEawaGL738RDq
	 ODSGAG3mTjWjrJFlDWym8g9aJsq2KrTBdeWT+f3L9hIS0AiqlvctvomWhcQtIYQ3QL
	 140zCyKJtreChas7SBPNEE7Vg/k5df3vRL0mxb0U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.133
Date: Mon,  6 Apr 2026 10:00:55 +0200
Message-ID: <2026040656-earring-timothy-3640@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233355-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 485143A21D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'm announcing the release of the 6.6.133 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile   |    2 +-
 fs/xattr.c |   10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

Al Viro (1):
      xattr: switch to CLASS(fd)

Greg Kroah-Hartman (1):
      Linux 6.6.133

Tomasz Kramkowski (1):
      Revert "xattr: switch to CLASS(fd)"


