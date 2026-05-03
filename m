Return-Path: <stable+bounces-242805-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCRqDemI92kDiwIAu9opvQ
	(envelope-from <stable+bounces-242805-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 19:42:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 875414B6D27
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 19:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF4E83001871
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 17:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190E03630B9;
	Sun,  3 May 2026 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ld1KFfXm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FA7253B58
	for <stable@vger.kernel.org>; Sun,  3 May 2026 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777830114; cv=none; b=GVh8m/Uw9TtNJDlPY6Qcmy+vW+87Qdg+9m15S63EuJ7/O112remitI3VRNlgf9LjLR1DYtXW2lhKnDD3x/1vD2WFbACp4yS+rLCcy3bEO6h6MgOl/e4LeBGsuo6G2RegrorPAVj+GPF2Zh+EW5/ZAUpmz13KzkxSM7Gcl4gCLFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777830114; c=relaxed/simple;
	bh=3zJp+AnV/+L6qJzij5vf/HZ7+9DoJhh/2Nl7k7PNvoQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fgbVEVxMoFR74ndeHt75075l29V7EFEHuRkQzGWUDSm4gGJRkGVbBXj6gQJDlGlt3986L+xJpx0m7Ipz7p6f+w31A86kA3tTZOwCbudNjviPMSQPSSfjxG7gDJLUJVEiS4pCIu/XtpXNg/fuS4yazGT8mUfymYlFUHJpVKtASic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ld1KFfXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6900EC2BCB4
	for <stable@vger.kernel.org>; Sun,  3 May 2026 17:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777830114;
	bh=3zJp+AnV/+L6qJzij5vf/HZ7+9DoJhh/2Nl7k7PNvoQ=;
	h=Date:From:To:Subject:From;
	b=ld1KFfXmz6U7ueteKMfam2cZ+NsUadHqDitjAg8rlrzVcdG8aEBrBb9ySbUNw6k09
	 oCv5Of1twalr+k29qikLs+zBHyHYdI+TLZ7PtjJf2N1W67AF6ZQDOHQ+H0vLFK1JzS
	 ajuXe0gN3zLPudKkN7xTIq8EQ7KnjaQkzHQYhA58tNAQhAr3vRA4qLNrsxRXWSFtB1
	 AyoaCIwHGOHYbUyMCXvMarNWlpcziS5EJzeLabtuk3QX9Vvyzxxw4z8co8FjGiPYCn
	 JQ0S8k03Zvz4QIDMlVHOLpb/ioT+PXhi+O3igUXqpvDukGHQsH1UVRmhj469OSryxJ
	 OTPGHgkbXsldQ==
Date: Sun, 3 May 2026 17:41:52 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Subject: Apply "crypto: authencesn - reject short ahash digests during
 instance creation"
Message-ID: <20260503174152.GA1036833@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 875414B6D27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242805-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Please cherry-pick 5db6ef9847717 ("crypto: authencesn - reject short
ahash digests during instance creation") to all stable and LTS kernels.

This one does have 'Cc: stable@kernel.org' already.  But I thought I'd
call it out specifically, given that it's in the same problematic file.

- Eric

