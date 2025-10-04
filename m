Return-Path: <stable+bounces-183383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2415ABB91D4
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 22:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C42D04E0621
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 20:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A732719D071;
	Sat,  4 Oct 2025 20:47:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C9214F70
	for <stable@vger.kernel.org>; Sat,  4 Oct 2025 20:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759610877; cv=none; b=UGG4ydxaCqZLolDICsS+ior7NySJR1Yy5AR1J5fGSwgVZhvy3aglU27vZEwa8SCBsuUkp0QolO+nrUZONps/yl/NJ7mQNWNiIuMM3SpoWCWxYZ4b0lTfE0IOEm3FGkuBit6Zz252lK3455s5N4MUw4cLR/hFTkdDCmJDtWZfxCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759610877; c=relaxed/simple;
	bh=aoaX6U2sdp5PVhj8G00gK4P5eRoCAUujjxbHUeX6MBk=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=g4l0SHV12tslpnyBSKduoIhjmX3uuAO2JOB+sVNP7MrYbc21k3Im5NQPVrpVMIYl05Fp3d39PsWhCjCYi1SFxiDll5E0t09/0qDkC2cwDFXFRV6GW/NGdd1cZo8Jn8fex4zXwvFaGvGPqnFQ6XBMV9IpP0dY80xB+kwRBKlk2Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from [192.168.2.4] (51b69db4.dsl.pool.telekom.hu [::ffff:81.182.157.180])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000088DE6.0000000068E187F4.002BC0DA; Sat, 04 Oct 2025 22:47:48 +0200
Message-ID: <c3e98ccee91993c1d0c3df4556ac172ae04234aa.camel@irl.hu>
Subject: 71d2893a235bf3b95baccead27b3d47f2f2cdc4c
From: Gergo Koteles <soyer@irl.hu>
To: stable@vger.kernel.org
Date: Sat, 04 Oct 2025 22:47:47 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hey Greg,

I think this commit should be applied to v6.16 stable, because without
it some speakers may be damaged.

Thanks,
Gergo

