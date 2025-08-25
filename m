Return-Path: <stable+bounces-172873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34437B3463E
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 17:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42BFC7B43D5
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 15:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B82023AB8B;
	Mon, 25 Aug 2025 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="SL0SwNB/"
X-Original-To: stable@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076A323D7F8
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756136863; cv=none; b=O3N4m4kk6G0uQqM0DFa8aKbiemMwk9F+8GXDhvPPoubpH5pRKPvHvpf9DDAs0c0bIMh7Wk7l/wfHRVYzf8FupjKiOIObQ/6k+N8KnusKess2XLtS11EztMwomy5fO9Oi4DYd33xMyxLILwFSKZLAooaJnX54nlX7wPBwnMV6KsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756136863; c=relaxed/simple;
	bh=tO4ICPHUrXrzE1bHmAtSZpmS55mFdB8ZtNyfvA9QeH8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=cL+7NEMMDaB0H+yeZldXxd7Kc6pWPDSp6AGf1qhDXlP3QH3kZcoHk3aRyUH59d01ZjR7R9oto+U3Q/BGUxsEM+aKE+b3C4ghhNhnqtrcmcShoTWJ8WdjmlUs6BlEy+lan5L5ez2wuufwFpgFEMSZEqABcJyqp8BSzrsYysN6+hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=SL0SwNB/; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.116] (p5de4594b.dip0.t-ipconnect.de [93.228.89.75])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id D48B72FC0047
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 17:47:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1756136852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Qrp3EZanseX4OLzy2V7hFeC61O1Utg75oyM0FesyEYc=;
	b=SL0SwNB/HL1ZwrsRXMagdUt7wWxYbwzBrTTn6c8g8dfVeI7VcCx/fQ4oNKglZXJrdGfBGN
	R0cu8f1LkYe4eMxps6bkN3wwHuAglXzu4DJmzn+9JxBCKQopOImB/o/Bx97leNEa623dNy
	7tWN9RSulgG97DS0jL8Y0TwWRwEA9fw=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <29a71bc0-a615-4bbd-be7a-a343a304e68e@tuxedocomputers.com>
Date: Mon, 25 Aug 2025 17:47:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: stable@vger.kernel.org
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
Subject: ACPI: EC: Add device to acpi_ec_no_wakeup[] qurik list
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Commit ID: 9cd51eefae3c871440b93c03716c5398f41bdf78

Why it should be applied: This is a small addition to a quirk list for which I 
forgot to set cc: stable when originally submitted it. Bringing it onto stable 
will result in several downstream distributions automatically adopting the 
patch, helping the affected device.

What kernel versions I wish it to be applied to: It should apply cleanly to 
6.1.y and newer longterm releases.

I hope I correctly followed 
https://docs.kernel.org/process/stable-kernel-rules.html#option-2 to bring this 
into stable.


