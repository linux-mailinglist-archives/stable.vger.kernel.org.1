Return-Path: <stable+bounces-223062-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCT4FvkxqGm+pQAAu9opvQ
	(envelope-from <stable+bounces-223062-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 14:22:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B070320052B
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 14:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1332730BD4E4
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 13:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BA61A683E;
	Wed,  4 Mar 2026 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPbUorSY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A967223DD6;
	Wed,  4 Mar 2026 13:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772630331; cv=none; b=pss+TF1HnlCaOLKcpfSJXkwDBAMyXHuLdZpOpvTl7+ws17Zu1TW4XzA2rZCr2Oab5noPG3yZ3RwW6GyO1BSbEUDe8RdqANDNSTfrrnISEkkMO7OPPl/YwfV+ckRKlo0ttIYqOZuIt5evrMkiMPP9evrP4kQ/x9uop22rBONdx/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772630331; c=relaxed/simple;
	bh=MaK5N5Qv4Kyf1rBLXySW+EkJ/Suxxb58sPZBdjzDtc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xf/aDolJx9jVlDOqG2sYZg4D5SsQzRqkTVdBuUBpHLuujAm2eaVOfWQ3ruonN0Vm7btVz+WqwrNB/v/sEwaRXhKSoWVVAYz/IIRBf9OknfAWS3Lox7Sf/8iikY3AOBEglvG09YmITKoONiNRSqsMget5PGWFPOk2/6MjmV7doKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPbUorSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFD8C19423;
	Wed,  4 Mar 2026 13:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772630331;
	bh=MaK5N5Qv4Kyf1rBLXySW+EkJ/Suxxb58sPZBdjzDtc8=;
	h=From:To:Cc:Subject:Date:From;
	b=rPbUorSYzMBWGtW4lHmAEC8u1POCN1CXSBNbvL4S4G8Bu9dGU6F/60XELTwim/fjK
	 wQ6flkJFMUUJTMv2TvHNC8d9o7iBdz//gR3fVupSRtSoMlSX4ZmPbmHx77vcox7w/g
	 9RDLsG7bkQbur4a9N4hnYQH3+V1XkGoJduOcmz0TSeZAbqZmVckNeUuRhT93ZRzwwI
	 i6HZCgTy9Cudc3d3uz9CcSnO4KeKJVzv4w8IPakrSix8YzPGlTPMQPbrJ+ZrG0+46H
	 /+thjVk+zvt2HzfzTfPDHGN1HPM04etakGxxUzz6YtbCpOwSFcuS0iZji2QkoD1NGp
	 MdeSfF5x6KGgA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	gregkh@linuxfoundation.org
Subject: Linux 5.10.252
Date: Wed,  4 Mar 2026 08:18:48 -0500
Message-ID: <20260304131849.87661-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B070320052B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-223062-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

I'm announcing the release of the 5.10.252 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
        https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary


Thanks,
Sasha

- ------------



-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAmmoMRUACgkQ3qZv95d3
LNzIvhAAjcITtYu19c5tVCwXUhgIzV0wWF+9rjR57iWfeVTAkmvK7t48dPJkEyVt
BmVbUAv9sqtJl9/v5WhbxpbN5fbcyHtpZrmhdXsqzJ8++1acbEI4vacG7Ed1AVe9
pUrj8ISdmJbs227cj3alawtGJHeAtPD2MEb8XWsCT/jUbwazEj0mqf0jMCFwB9d0
g9JM7nRy2KzZudvyxcV7xXisiZhVMB/jT8Pj7RsVPrWm58/5LVrnDYHdP7eLzSgo
TWgl0bJvVF5ZuFwUNjHOrD6ceywZVsa/1cafNkdiAAXR32ihq9VZTTb95IO3ZfHv
haGLJEdStyczprtSHTapNesDreVb5SX3l7Whw1SuEEpm7CSgd2PPiASqIuhNYky4
CIpkrOBP0EZL5sOiaG0dTMrSONnb5tg6uCypIkcJlXqvZJvLbgXI2v/8mmRdT3X3
wHQFXhReir8FEEZmnOd7FJmRznih9WkLQMO93QZv44U0svG/e7d0K1tTIt5pJdVJ
NPbAt4ekPQYN6M5HnHKl6eJPWUXsNJfLffp4ASD3JxG4Od359G96Jt+BKPhV5ngl
h7mlV6XNcyxTGjxzpJEXlmOJFqob/Rg6rq88cdG9Flz+1pQftYqlx9MhxjtveJT5
3D5ZcEL1x/5bjNnjNH5Vl9A7cp4M0pIUCIEzrNOX1x1A3FGWNoo=
=3ZRu
-----END PGP SIGNATURE-----

