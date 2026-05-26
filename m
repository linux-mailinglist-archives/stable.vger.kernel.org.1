Return-Path: <stable+bounces-254402-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOHVBSDXFWoSdAcAu9opvQ
	(envelope-from <stable+bounces-254402-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 19:23:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E4E5DA95B
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 19:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0980330B6EB5
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 17:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E943FF8B9;
	Tue, 26 May 2026 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="qAHEmszn"
X-Original-To: stable@vger.kernel.org
Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch [185.70.43.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29943A7F7C
	for <stable@vger.kernel.org>; Tue, 26 May 2026 17:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815335; cv=none; b=bD+ZHB9P9TloTeW05/THF6f4Xsrx/FY1iAGJwVNkXgow9KhtPW/gn2lHJj2llpri+ocp5amT5mxJTmdk2tXeNXmPmL2fC5xnGFiPZ4BflySwHqD763ulyx+8srIK4mg8hhzZ+wMBI+WC9k57wojVcyrwyIAJDXr0gSCI0ZHVH/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815335; c=relaxed/simple;
	bh=IAu5WjrtA76YLBy+AfYKdOu0PCN7Cw61QpauR/9t67I=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=RcZJQd1izbReqiftZmvbzcqLIMZQyExb/5IWe9yQa1/HGr1NHPPWnOU7m1FpyzsRjJnzUP4dCHg70McVdJHOZmRQloPO4motGRZ19yCugtqwyRaPK6X0DIlKh2AjCpcppijefKLXqePxDYfbiHUrDRwJO1yvRZH+j6cKgX8s2ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=qAHEmszn; arc=none smtp.client-ip=185.70.43.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1779815326; x=1780074526;
	bh=IAu5WjrtA76YLBy+AfYKdOu0PCN7Cw61QpauR/9t67I=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=qAHEmsznciDft2UIbqagJaRImSFnvSkdhUxcCscF4qzDUSNEVAeuXLDhzUkYmGexF
	 58cjVjOjxppOXe3hs8UQTX0v1LD+diS3NKmVxtmxUKmRIA7QqsULB3wTqOrKkenhQo
	 geaSGKtGz9oNhI/hP/ovM4TaRPQa7hwXAwAkJYX/1XCvvywgFtytgi/asCKUy7Hk7V
	 g7cJoPu8aoB3ME2MnvesnXRcbUJgJNAVdN2d31fd3WsL7ZPvExjH9K44CK6lpJAjKR
	 DCP6ILzP8wU7J6qgVKlguoSjDAGAauzBEVr8T2L50zzBC8/WWb5IBoIBhwsBJbQaa/
	 u3k8NzHKwcb7Q==
Date: Tue, 26 May 2026 17:08:43 +0000
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: manizada <manizada@pm.me>
Subject: Please apply 3da1fdf4efbc to stable
Message-ID: <HWDVTGhsU6ON7YOl4ipsBa-4aBO4UMs2EdpPPhEyYoOWmVqbo__aVWaSuEIqescKSIxPJalwVPc2BQax8VsPmuZUXyF14lBaCyyrnu2_40g=@pm.me>
Feedback-ID: 37265593:user:proton
X-Pm-Message-ID: 8648830325c8268e0bcf0d901ace1cfdb92469a3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pm.me,quarantine];
	R_DKIM_ALLOW(-0.20)[pm.me:s=protonmail3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-254402-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[pm.me:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manizada@pm.me,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 71E4E5DA95B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi stable team,

Please apply the following upstream commit to the supported stable trees:

=C2=A0 3da1fdf4efbc490041eb4f836bf596201203f8f2
=C2=A0 smb: client: reject userspace cifs.spnego descriptions

Reason:
=C2=A0 cifs.spnego descriptions contain authority-bearing fields consumed b=
y
=C2=A0 cifs.upcall. This commit prevents userspace from creating trusted
=C2=A0 cifs.spnego descriptions via request_key(2)/add_key(2).

Requested branches:
=C2=A0 Please apply to all currently supported stable/LTS branches where it=
 is
=C2=A0 applicable, including 7.0.y, 6.18.y, 6.12.y, 6.6.y, 6.1.y, 5.15.y, a=
nd
=C2=A0 5.10.y.

The kernel-side issue is old; the merged fix is small and self-contained.

Thanks,
Asim

