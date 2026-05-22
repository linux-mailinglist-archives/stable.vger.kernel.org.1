Return-Path: <stable+bounces-253668-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBPELlGzD2rBOwYAu9opvQ
	(envelope-from <stable+bounces-253668-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 03:37:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B85D5ADB68
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 03:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEE06300CE6C
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 01:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3703429D266;
	Fri, 22 May 2026 01:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5di9YeV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A743285417;
	Fri, 22 May 2026 01:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779413789; cv=none; b=TKXN+IfKS2L+qSvPi3wke1tLY0Xy+tgQSVVD4/4JAzMr6CCqe5HD4H7vCF4/JvQ5asYEi0TyPOCMxkv/ZZnB7ygUP5kal8uUt3LW7n5mLceQ5vFROATMbTeKkvtBAl+NVm6j0ZyN4JAmGvW0l0J05ABQKov4Um8GdU+KjYIY1Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779413789; c=relaxed/simple;
	bh=5zSDN3OZ4Wm32go+ZAXfzL0oAU9HDVj1ivV5Q1OmXww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6maSzcWF6RpesgpOL7MNLtFIL/g/Z59VmX8nzEiRhL9ZqlsdDKniApF9I+rs6LGmIEVbmuZlDMppes1nlR2dkX9XfO0qp5lxeHFLmKJcW+A027ndGU0DKFWmg5KRO0Zn/zqshATtJdEcdgM7YWotyxdAVQSgSC5K4RNdt+GJT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5di9YeV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FD41F000E9;
	Fri, 22 May 2026 01:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779413787;
	bh=bk5CKHgNLyizoEYy0Jkl0jjBCMkIHtqmJDS0fCcxmb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n5di9YeVKHw7HLS7on+wrFw2Geuv7q6f3E/jzhs64fhpPPE43G1p/q98FP8gAlGog
	 Nj5u6qBNracmjOMptTXbllDpB6z7HSEGS7E1osKyCnZEIuSaccGnGnfI03Y3yvjP8l
	 q35uJr+wplsn7NfmFsMgXDvhVGZiRp1WJqgTO94ngSCEzTN77FAi6gVh5vADvnHwlS
	 pLVe9/8dIjCYf8M9bW2EopAtFm0iD5n6cHKn74DONsERn4K1eB2XuerTNVAYpOHtnK
	 /NZeR9ZkhEBPcw+qAK2KwUM8fybnYr5Wx3iK2LSvKoypnj2QfshLhFKtWvEZyssTKn
	 S4aexG/CrlSLw==
From: William Breathitt Gray <wbg@kernel.org>
To: Raymond Tan <raymond.tan@intel.com>,
	"Felipe Balbi (Intel)" <balbi@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] counter: intel-qep: Use devm_mutex_init()
Date: Fri, 22 May 2026 10:36:15 +0900
Message-ID: <177941369796.201156.12547650998958016276.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520111813.3934-1-ilpo.jarvinen@linux.intel.com>
References: <20260520111813.3934-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=414; i=wbg@kernel.org; h=from:subject:message-id; bh=eQ7ixMxhd3FQ1efTnbIk1MvQR/tAfoVRo4eMUS+udkM=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFn8m07/Ef6pord7nwHbs39874Lc8/W3R8Qp3Tep1zP4f 9y2NKqho5SFQYyLQVZMkaXX/OzdB5dUNX68mL8NZg4rE8gQBi5OAZiIphXDf/+0o2q1d1WiX+z/ c4Tl9v3+4LvuAcxvi6qTXi7ImOJlLsfI0BSzLNZk18lqJaV+zz2xaWtklENOT/PRW1vOIJYl85i fEwA=
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253668-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wbg@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5B85D5ADB68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, 20 May 2026 14:18:12 +0300, Ilpo Järvinen wrote:
> intel_qep_probe() calls mutex_init() but lacks the pairing
> mutex_destroy() calls. Convert to devm_mutex_init() which handles
> cleanup automatically.
> 
> 

Applied, thanks!

[1/1] counter: intel-qep: Use devm_mutex_init()
      commit: ff35c72101d1dc6793496ade9c1bc3d70dd27bdd

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>

