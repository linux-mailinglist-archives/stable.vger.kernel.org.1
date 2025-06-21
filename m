Return-Path: <stable+bounces-155218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8044AE2823
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 10:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D6C3ADAD4
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 08:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DDA1E9B28;
	Sat, 21 Jun 2025 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kk3yFhtx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B811E835C
	for <stable@vger.kernel.org>; Sat, 21 Jun 2025 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750495917; cv=none; b=msQRlwPgC8KkeJZksISZHqUhgC9/Y2RzY3/1Zg1y45BnQ93aSNozwrfVzcsEXyU+lOKn8sVkqQet/asOwoD2HWnkUQhlNglWcEKjhsAffbWx9GUP1F8YcwUepjJytDXJH5esu74TYpesQaFMZpq6B6gD20fGElUqGLnnim9JOhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750495917; c=relaxed/simple;
	bh=us1MK57y6DWBrJIr77WyFhClqi7R1mE4zCFDxbHrywI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FrXpANf5ZFTfkNShOmGeUSIuB6TBHb+gEDuguI9K+DcyK/58kuWZf6lUQMP4ijgjcVu1cgdhQzjE9RJzJH94TP2nG0UxUiuoj6N3hNxwfIUHSg3rmUtqoXk5ZBUVcchhQBFdKf1XwTh/pgkvQy+ATwUD8c8BN3+9a5ghwufZaZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kk3yFhtx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF50C4CEF0;
	Sat, 21 Jun 2025 08:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750495917;
	bh=us1MK57y6DWBrJIr77WyFhClqi7R1mE4zCFDxbHrywI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kk3yFhtxOMUJ1z58BCAfO7GyzdFayUOlITY2qMNBNwDHZZOMVFUUUcioBr+0jyvPA
	 NXCuSllLLJNM5maRAVesW8YkTldqDcLqdhAamGInfYlzqihQ/HWYWWAeTnIEYhNR81
	 TjIs9ZxbgAsKTzm1vZD6nLwJLFEPd+otq24IoQRYwKeA8Noi58Rw2LKJsIoUDOrZja
	 nmA/q/7Bk/TTTZzFw8f9n4L9SKaW1/kD3Md2RaSUjfaIVhvk+YgATHPsWW7JsQygmd
	 RGcxGUJegKSG476QQUxG1nY2zJSH+3iqGeAMYZDrj6ZfXjNkgMi4XTnLhSBNCxpL9i
	 XFXu3VTasJiyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: WangYuli <wangyuli@uniontech.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1/6.6] wifi: cfg80211: init wiphy_work before allocating rfkill fails
Date: Sat, 21 Jun 2025 04:51:55 -0400
Message-Id: <20250620232247-fedbdc7782b3f56b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <A203ED8C00632F28+20250620031949.227937-1-wangyuli@uniontech.com>
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

The upstream commit SHA1 provided is correct: fc88dee89d7b63eeb17699393eb659aadf9d9b7c

WARNING: Author mismatch between patch and upstream commit:
Backport author: WangYuli<wangyuli@uniontech.com>
Commit author: Edward Adam Davis<eadavis@qq.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  fc88dee89d7b6 ! 1:  086f38a03332b wifi: cfg80211: init wiphy_work before allocating rfkill fails
    @@ Metadata
      ## Commit message ##
         wifi: cfg80211: init wiphy_work before allocating rfkill fails
     
    +    [ Upstream commit fc88dee89d7b63eeb17699393eb659aadf9d9b7c ]
    +
         syzbort reported a uninitialize wiphy_work_lock in cfg80211_dev_free. [1]
     
         After rfkill allocation fails, the wiphy release process will be performed,
    @@ Commit message
         Signed-off-by: Edward Adam Davis <eadavis@qq.com>
         Link: https://patch.msgid.link/tencent_258DD9121DDDB9DD9A1939CFAA0D8625B107@qq.com
         Signed-off-by: Johannes Berg <johannes.berg@intel.com>
    +    Signed-off-by: WangYuli <wangyuli@uniontech.com>
     
      ## net/wireless/core.c ##
     @@ net/wireless/core.c: struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |

