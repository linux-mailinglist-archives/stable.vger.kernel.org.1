Return-Path: <stable+bounces-164979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 626C6B13DBF
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 16:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A84F177653
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 14:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61B026AAAA;
	Mon, 28 Jul 2025 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGuVGXOq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9535234CF5
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753714664; cv=none; b=j3dIqn2vkXeDUaymz/cBfeB9XgZs6GI/SQb203P6g7jeww3glj14QD9SYRmtfReXiC/9zPB4eqAjhHSV9EF8h6zVSvL+ZxBD/ze9f0uxeFbFwmjyJNvWuawBkXEbSLWXH8ORpP+GeKTZscD98ZTLIms+jg08jluaPqZVQRoOZew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753714664; c=relaxed/simple;
	bh=i6A/bdH8l9BGZh9U41LJKOIheS+jGlVGOnpFehxnOCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9ijNt1QAwJJhEkJ8mcXIz4zucr/0GFvn7Amn7y5eSPRKqNXi5+G0VixtR260fgruhCQlkkcjZ/RZgVyPnxS1OW/rVGPZgOGlXC7s9lPyzF/XKvINCGMwqfZbDSAEvqlDqzyxlel8KfmCbn3v9Uh7vacRN+30JF7XVgQMgvQACc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGuVGXOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC612C4CEE7;
	Mon, 28 Jul 2025 14:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753714664;
	bh=i6A/bdH8l9BGZh9U41LJKOIheS+jGlVGOnpFehxnOCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UGuVGXOqE4fldWZTZqcIN+a44tpTB1iwwI7+BNKBfaHoH3t3an0TgAfx+34ToJcVH
	 8YwVuGq9pO+Bf1EydGnFsqGhX9gYVlZEZVDz4ANQedeVoEwVLfxggT+uYha5iY/aia
	 kNBPHPWr+2m4BcwsHTYOib1FcesMDSjuOMPk4jOZCo7/81YrDOmWmJVtDUSrkTkW16
	 IjIufdnjSjJf19KS5AUJAousmA4E6SzfqbT/WJIU3GUk3k/U4yu+b8qyZXFji5oQb5
	 oDqP0Ww4V0Srsk5NMYZMw2xsLeil7uNLeNH32z0glU+rhlFI1R7z0VhPGFRmUCRJpw
	 w3j2P52OYMcgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 5.4] comedi: Fail COMEDI_INSNLIST ioctl if n_insns is too large
Date: Mon, 28 Jul 2025 10:57:41 -0400
Message-Id: <1753711981-bc9e95e3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250728121821.276086-1-abbotti@mev.co.uk>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 08ae4b20f5e82101d77326ecab9089e110f224cc

Status in newer kernel trees:
6.15.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  08ae4b20f5e8 < -:  ------------ comedi: Fail COMEDI_INSNLIST ioctl if n_insns is too large
-:  ------------ > 1:  35bddb9d95d3 comedi: Fail COMEDI_INSNLIST ioctl if n_insns is too large

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.4.y        | Success     | Success    |

