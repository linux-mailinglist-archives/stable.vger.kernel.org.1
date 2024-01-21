Return-Path: <stable+bounces-12322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A351835449
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 04:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C671C1F21F92
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 03:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5A233CD0;
	Sun, 21 Jan 2024 03:10:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F6ED26A;
	Sun, 21 Jan 2024 03:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705806606; cv=none; b=sIemHJajEZQeHvpPhJsd/VyNMaFglAxs0CjLJhtEG1QKsX905sCxfopQHv/VWfiMidpsJiwbzY+eSsqZZMJ7WYi88Ct5BD6VX4kZ5VXNojErM1hRVjRosVtmjhD5L/jrDZLIdKfAx0gnTonhV9Imd2QI7Oi2IBAtsOzXXySRpLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705806606; c=relaxed/simple;
	bh=I3WwvVTdusDDUCqoz87HV7bQd0RnQzvJN1fmpiXYm7c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pk0/X3NJb0qrirEfyNtGCMWAj6ul+xvgl7Ef+2+XEk2V7OXxYbKTdov89heb1Qu0seIP3R0PrQRdGSjDUor0WmCta4MwRSmLSomwtg5EQX10a8tAOVruzrWH21ARidLyX5uJPGsKfKbB2nuLNBfV9VOa7NKdSkPqhvtDExHbBto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 94E6280241;
	Sun, 21 Jan 2024 02:33:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id B211D20025;
	Sun, 21 Jan 2024 02:33:49 +0000 (UTC)
Message-ID: <b28a42964abc1d67ce7d03d9660e855dc00622b4.camel@perches.com>
Subject: Re: Patch "rtlwifi: Use ffs in <foo>_phy_calculate_bit_shift" has
 been added to the 5.4-stable tree
From: Joe Perches <joe@perches.com>
To: Sasha Levin <sashal@kernel.org>, stable-commits@vger.kernel.org, 
	"stable@vger.kernel.org"
	 <stable@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>
Date: Sat, 20 Jan 2024 18:33:46 -0800
In-Reply-To: <20240121014845.662779-1-sashal@kernel.org>
References: <20240121014845.662779-1-sashal@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: B211D20025
X-Rspamd-Server: rspamout08
X-Stat-Signature: gdwjc9unynapcwhb7ehpsm6mt1tzh73o
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18vP7F6RQBVwFKycDeLS5jrGa2eg57mAHk=
X-HE-Tag: 1705804429-848165
X-HE-Meta: U2FsdGVkX1+PNpT1qhopuVXvoUfvhVcSiRpXZ44q++OUYQrwKqs+DR7ti4d59OkYJ50I7oVlhUQ/SKe7uCG+CeLJWbqdfGvdmA6moREDJiTpaK/GfscKca8YEb9Wf5kwqbxn083NyhAcYo00rMF2BIsx+qiNbUFyAsYooMEs5m2ih7UrSafiAkPDAroFhxtYtkwS/PL2DPW0Jd/dpsFH+NGR1DKZWq30eKsLZdnATpDM9FV6Bd0e1XhO2B08Px101T6z1RA84dOv6XjyHp8J5fY3ez0Kf6nrLffFbJSd9NILG7TNGig8+kF4YmqsbbkyJ9m99hUcFA0FTf/NpU7n2qB4poengTig6M5geh4YxbbtT/RBLd8cSqjG8dazdQ5OkysL5DGMx1vZIpAv5RqcrrVqT0ThiSTXBM0HDv5B50jkwXaSt3C+lGKiULr+1D3cRK9WkLC8o2XaFtbPnXr88ibkwD4UpU0o6G7Mip4GdkeQg9k2J6qbiA==

On Sat, 2024-01-20 at 20:48 -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>=20
>     rtlwifi: Use ffs in <foo>_phy_calculate_bit_shift

Why?  There's no change in behavior.
Not a candidate for stable IMO.
Same for 4.19.

>=20
> to the 5.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>=20
> The filename of the patch is:
>      rtlwifi-use-ffs-in-foo-_phy_calculate_bit_shift.patch
> and it can be found in the queue-5.4 subdirectory.
>=20
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>=20
>=20
>=20
> commit a5dba4741aebf44a1371d4559b5c13535a440c38
> Author: Joe Perches <joe@perches.com>
> Date:   Fri Sep 18 23:37:47 2020 -0700
>=20
>     rtlwifi: Use ffs in <foo>_phy_calculate_bit_shift
>    =20
>     [ Upstream commit 6c1d61913570d4255548ac598cfbef6f1e3c3eee ]
>    =20
>     Remove the loop and use the generic ffs instead.
>    =20
>     Signed-off-by: Joe Perches <joe@perches.com>
>     Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>     Link: https://lore.kernel.org/r/e2ab424d24b74901bc0c39f0c60f75e871adf=
2ba.camel@perches.com
>     Stable-dep-of: bc8263083af6 ("wifi: rtlwifi: rtl8821ae: phy: fix an u=
ndefined bitwise shift behavior")
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>=20
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c b/drive=
rs/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
> index 96d8f25b120f..52b0fccc31f8 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
> @@ -16,7 +16,12 @@ static u32 _rtl88e_phy_rf_serial_read(struct ieee80211=
_hw *hw,
>  static void _rtl88e_phy_rf_serial_write(struct ieee80211_hw *hw,
>  					enum radio_path rfpath, u32 offset,
>  					u32 data);
> -static u32 _rtl88e_phy_calculate_bit_shift(u32 bitmask);
> +static u32 _rtl88e_phy_calculate_bit_shift(u32 bitmask)
> +{
> +	u32 i =3D ffs(bitmask);
> +
> +	return i ? i - 1 : 32;
> +}
>  static bool _rtl88e_phy_bb8188e_config_parafile(struct ieee80211_hw *hw)=
;
>  static bool _rtl88e_phy_config_mac_with_headerfile(struct ieee80211_hw *=
hw);
>  static bool phy_config_bb_with_headerfile(struct ieee80211_hw *hw,
> @@ -210,17 +215,6 @@ static void _rtl88e_phy_rf_serial_write(struct ieee8=
0211_hw *hw,
>  		 rfpath, pphyreg->rf3wire_offset, data_and_addr);
>  }
> =20
> -static u32 _rtl88e_phy_calculate_bit_shift(u32 bitmask)
> -{
> -	u32 i;
> -
> -	for (i =3D 0; i <=3D 31; i++) {
> -		if (((bitmask >> i) & 0x1) =3D=3D 1)
> -			break;
> -	}
> -	return i;
> -}
> -
>  bool rtl88e_phy_mac_config(struct ieee80211_hw *hw)
>  {
>  	struct rtl_priv *rtlpriv =3D rtl_priv(hw);
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c b=
/drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c
> index 0efd19aa4fe5..1145cb0ca4af 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c
> @@ -145,13 +145,9 @@ EXPORT_SYMBOL(_rtl92c_phy_rf_serial_write);
> =20
>  u32 _rtl92c_phy_calculate_bit_shift(u32 bitmask)
>  {
> -	u32 i;
> +	u32 i =3D ffs(bitmask);
> =20
> -	for (i =3D 0; i <=3D 31; i++) {
> -		if (((bitmask >> i) & 0x1) =3D=3D 1)
> -			break;
> -	}
> -	return i;
> +	return i ? i - 1 : 32;
>  }
>  EXPORT_SYMBOL(_rtl92c_phy_calculate_bit_shift);
> =20
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c b/drive=
rs/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
> index 667578087af2..db4f8fde0f17 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
> @@ -162,14 +162,9 @@ static u32 targetchnl_2g[TARGET_CHNL_NUM_2G] =3D {
> =20
>  static u32 _rtl92d_phy_calculate_bit_shift(u32 bitmask)
>  {
> -	u32 i;
> -
> -	for (i =3D 0; i <=3D 31; i++) {
> -		if (((bitmask >> i) & 0x1) =3D=3D 1)
> -			break;
> -	}
> +	u32 i =3D ffs(bitmask);
> =20
> -	return i;
> +	return i ? i - 1 : 32;
>  }
> =20
>  u32 rtl92d_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bi=
tmask)
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c b/drive=
rs/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c
> index 222abc41669c..420f4984bfb9 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c
> @@ -206,13 +206,9 @@ static void _rtl92ee_phy_rf_serial_write(struct ieee=
80211_hw *hw,
> =20
>  static u32 _rtl92ee_phy_calculate_bit_shift(u32 bitmask)
>  {
> -	u32 i;
> +	u32 i =3D ffs(bitmask);
> =20
> -	for (i =3D 0; i <=3D 31; i++) {
> -		if (((bitmask >> i) & 0x1) =3D=3D 1)
> -			break;
> -	}
> -	return i;
> +	return i ? i - 1 : 32;
>  }
> =20
>  bool rtl92ee_phy_mac_config(struct ieee80211_hw *hw)
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.c b/drive=
rs/net/wireless/realtek/rtlwifi/rtl8192se/phy.c
> index d5c0eb462315..9696fa3a08d9 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.c
> @@ -16,14 +16,9 @@
> =20
>  static u32 _rtl92s_phy_calculate_bit_shift(u32 bitmask)
>  {
> -	u32 i;
> -
> -	for (i =3D 0; i <=3D 31; i++) {
> -		if (((bitmask >> i) & 0x1) =3D=3D 1)
> -			break;
> -	}
> +	u32 i =3D ffs(bitmask);
> =20
> -	return i;
> +	return i ? i - 1 : 32;
>  }
> =20
>  u32 rtl92s_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bi=
tmask)
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.c=
 b/drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.c
> index aae14c68bf69..964292e82636 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723com/phy_common.c
> @@ -53,13 +53,9 @@ EXPORT_SYMBOL_GPL(rtl8723_phy_set_bb_reg);
> =20
>  u32 rtl8723_phy_calculate_bit_shift(u32 bitmask)
>  {
> -	u32 i;
> +	u32 i =3D ffs(bitmask);
> =20
> -	for (i =3D 0; i <=3D 31; i++) {
> -		if (((bitmask >> i) & 0x1) =3D=3D 1)
> -			break;
> -	}
> -	return i;
> +	return i ? i - 1 : 32;
>  }
>  EXPORT_SYMBOL_GPL(rtl8723_phy_calculate_bit_shift);
> =20
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c b/drive=
rs/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
> index 8647db044366..11f31d006280 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
> @@ -27,7 +27,12 @@ static u32 _rtl8821ae_phy_rf_serial_read(struct ieee80=
211_hw *hw,
>  static void _rtl8821ae_phy_rf_serial_write(struct ieee80211_hw *hw,
>  					   enum radio_path rfpath, u32 offset,
>  					   u32 data);
> -static u32 _rtl8821ae_phy_calculate_bit_shift(u32 bitmask);
> +static u32 _rtl8821ae_phy_calculate_bit_shift(u32 bitmask)
> +{
> +	u32 i =3D ffs(bitmask);
> +
> +	return i ? i - 1 : 32;
> +}
>  static bool _rtl8821ae_phy_bb8821a_config_parafile(struct ieee80211_hw *=
hw);
>  /*static bool _rtl8812ae_phy_config_mac_with_headerfile(struct ieee80211=
_hw *hw);*/
>  static bool _rtl8821ae_phy_config_mac_with_headerfile(struct ieee80211_h=
w *hw);
> @@ -274,17 +279,6 @@ static void _rtl8821ae_phy_rf_serial_write(struct ie=
ee80211_hw *hw,
>  		 rfpath, pphyreg->rf3wire_offset, data_and_addr);
>  }
> =20
> -static u32 _rtl8821ae_phy_calculate_bit_shift(u32 bitmask)
> -{
> -	u32 i;
> -
> -	for (i =3D 0; i <=3D 31; i++) {
> -		if (((bitmask >> i) & 0x1) =3D=3D 1)
> -			break;
> -	}
> -	return i;
> -}
> -
>  bool rtl8821ae_phy_mac_config(struct ieee80211_hw *hw)
>  {
>  	bool rtstatus =3D 0;


