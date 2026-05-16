Return-Path: <stable+bounces-248994-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJW5H55MCGpqigMAu9opvQ
	(envelope-from <stable+bounces-248994-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 12:53:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4B255B36D
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 12:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8795830157D0
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 10:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFDD3A962C;
	Sat, 16 May 2026 10:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="drX/5pBc"
X-Original-To: stable@vger.kernel.org
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7078318871F;
	Sat, 16 May 2026 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778928793; cv=none; b=M4HIbzQaYuGKBBWdDhrjIZidf7TWDaOyNwjDHrCYydz3Ic/pD0DzIaFyRLqGu91G1EciAjigSoiOJbg9I4fdndBwOfN0zIQSFVQtc/pur12iWS364lAKW+TQlLVJ5UGIYfyEhGgZCmK+YyNGhSWfWfjrwp41xTwNHE8K/D8zA04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778928793; c=relaxed/simple;
	bh=HMN0Opx70ZpbUamtCMUOUexTMQIX0j6dZQegMJ7oDS8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kXApv7BOVp5jo/mvB6MR3G5+YV1VLVhOdUQMZ8rv4eBbySSKwS2bEi29aIW7ekvouAtNLc2j1kGBOwo/WLIzgiEPoZXUaXQbKM+fJuoegzvgg8FrAMABn+zL2BiLyd9+v9REFrwahFrUqes3jBsDPh5p5qLxkWFK+LME9QDPT0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=drX/5pBc; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=q4wozfbm5rafhoxcupfh3w4bli.protonmail; t=1778928787; x=1779187987;
	bh=HMN0Opx70ZpbUamtCMUOUexTMQIX0j6dZQegMJ7oDS8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=drX/5pBczQkIt+yBQRTDCiJvlYrRwo8rb3J3nasnx700OrlYFLG/L7ry+/2V1gb2W
	 uvC0fUB0Vj7fdCXpGIshHEnqrJXtxUw6SM2a/Tselr8wjRVvmlPytLu4AGQh1R5K8V
	 Ejq0ubl20j6iJrY8kPedUUB1tQaN7Ze0W2PJuPCTIZtVZlXlnpXTXR9nO2k8IMrk7z
	 XMFmAu1u5eyEVoJxniOx95cv9y8f9ZjQWBuGWQuzV34ogHyrtGchVoidjqDB+fPbYC
	 T6XXHt0ESGWoo+V1hzgNoiibHzWUT6yDXa3jyBLQkPz47FYZWeloAR8P0SzLQYPxMl
	 9VNUE9oYfTusg==
Date: Sat, 16 May 2026 10:53:02 +0000
To: "cassel@kernel.org" <cassel@kernel.org>, "ipylypiv@google.com" <ipylypiv@google.com>, "dlemoal@kernel.org" <dlemoal@kernel.org>
From: Christoph Wiese <charon56@proton.me>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ata: libata-scsi: fix requeue of deferred ATA PASS-THROUGH commands
Message-ID: <-LfISXRga4ryMCYwCMNrhBwgNW6mZ9xx8AWX-Y7B0WwEyZr_8BHlTEgNarxj36MY0Yu-79B93UH7ISr1OmMrRqAbO_LYmZjUgtkE0MoxB5M=@proton.me>
Feedback-ID: 197824547:user:proton
X-Pm-Message-ID: 78acbf9fcc5fbe869f251213226c6e693ac12275
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: DA4B255B36D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FAKE_REPLY(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=q4wozfbm5rafhoxcupfh3w4bli.protonmail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248994-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charon56@proton.me,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

(my orginal email was html formated, sorry about that)

Hi Niklas,

I notice you already flagged this for backporting to 7.0 stable. Please=
=C2=A0also include 6.12.y - the buggy parent commit 0ea84089dbf6 was backpo=
rted to 6.12.77 as 5d61a38a60e6, and the bug reproduces there.

Symptom: parallel sedutil-cli --setLockingRange against multiple ATA=C2=
=A0OPAL SEDs causes one random drive per invocation to receive a zero-lengt=
h TRUSTED RECEIVE response ("One or more header fields have 0 length / Sess=
ion start failed rc =3D 136"). The OPAL session is opened on the drive by t=
he TRUSTED SEND but the matching TRUSTED RECEIVE is failed at the SCSI mid-=
layer (scmd->allowed =3D=3D 0 for SG_IO), leaving an orphan session that on=
ly a cold power cycle clears.

Bisect on Debian's 6.12.y kernel (which carries 5d61a38a60e6 unmodified):=
=C2=A06.12.74 works, 6.12.86 broken. I've been running 8ebf408 locally as a=
 cherry-pick on 6.12.88 for ~24h; six OPAL SEDs unlock cleanly on every boo=
t.

Thanks for the fix.

